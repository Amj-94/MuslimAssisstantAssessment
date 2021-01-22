//
//  HomeVC.swift
//  MuslimAssisstantAssessment
//
//  Created by Abo-Aljoud94 on 1/20/21.
//

import UIKit

// There is one warning in this Project which is:
// nw_protocol_get_quic_image_block_invoke dlopen libquic failed
// I am getting this warning since I updated to Xcode12
// I serched the internet about this warning and found many developers are agetting
// the same warning(on applu forum and stackoverflow)
// current Xcode version: 12.2
// current MacOS: macOS Big Sur 11.1

class HomeVC: UITableViewController {
    // MARK: -properties
    var countries: [String]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    var backGroundColor = UIColor.white
    var textColor = UIColor.black
    
    var filteredCountries: [String]?
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var inSerachMode: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    // MARK: -LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayOut()
        fetchCountries()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpNavigationBar()
    }
    
    // MARK: -API Calls
    func fetchCountries() {
        APIManager.shared.getCountries() { [weak self] (res) in
            switch res {
            case .success(let array):
                self?.countries = array
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    // MARK: -setUpLayOut
    func setUpLayOut() {
        setUpColors()
        setUpSearchController()
        setUpTableView()
    }
    
    func setUpColors(){
        if #available(iOS 13.0, *) {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                backGroundColor = .black
                textColor = .white
            }
        }
    }
    
    func setUpNavigationBar(){
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.largeTitleTextAttributes = [.foregroundColor: textColor]
            appearance.backgroundColor = backGroundColor
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = true
        navigationItem.title = "Countries"
    }
    
    func setUpTableView() {
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = backGroundColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: COUNTRY_CELLID)
        tableView.rowHeight = 60
    }
    
    func setUpSearchController(){
        searchController.searchBar.showsCancelButton = false
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a country"
        definesPresentationContext = false
        
        if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textfield.textColor = .black
            textfield.backgroundColor = .white
        }
        searchController.searchResultsUpdater = self
    }
}

// MARK: -Extension Configure tableViewController
extension HomeVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inSerachMode ? filteredCountries?.count ?? 0 : countries?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: COUNTRY_CELLID, for: indexPath)
        cell.backgroundColor = backGroundColor
        cell.textLabel?.textColor = textColor
        cell.textLabel?.text = inSerachMode ? filteredCountries?[indexPath.row] ?? "" : countries?[indexPath.row] ?? ""
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CountryDetailsVC()
        vc.country = inSerachMode ? filteredCountries?[indexPath.row] ?? "" : countries?[indexPath.row] ?? ""
        present(vc, animated: true, completion: nil)
    }
}

// MARK: -UISearchResultsUpdating
extension HomeVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        guard let countries = countries else { return }
        filteredCountries = countries.filter({ (country) -> Bool in
            return country.contains(searchText)
        })
        tableView.reloadData()
    }
}
