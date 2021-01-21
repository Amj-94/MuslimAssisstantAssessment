//
//  HomeVC.swift
//  MuslimAssisstantAssessment
//
//  Created by Abo-Aljoud94 on 1/20/21.
//

import UIKit

class HomeVC: UITableViewController {
    // MARK: -properties
    var countries: [String]? {
        didSet {
            tableView.reloadData()
        }
    }
    
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
        setUpNavigationBar()
        setUpSearchController()
        setUpTableView()
    }
    
    func setUpNavigationBar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .gray
        navigationController?.navigationBar.isTranslucent = true
        navigationItem.title = "Countries"
    }
    
    func setUpTableView() {
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .white
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
            textfield.textColor = .systemPurple
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
        cell.textLabel?.text = inSerachMode ? filteredCountries?[indexPath.row] ?? "" : countries?[indexPath.row] ?? ""
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CountryDetailsVC()
        vc.country = countries?[indexPath.row] ?? ""
        if #available(iOS 13.0, *) {
            vc.isModalInPresentation = true
        } 
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
