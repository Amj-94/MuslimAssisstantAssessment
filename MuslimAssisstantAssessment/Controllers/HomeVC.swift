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
        setUpTableView()
    }
    
    func setUpTableView() {
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: COUNTRY_CELLID)
        tableView.rowHeight = 60
    }
    
    // MARK: -Controls
    
}

// MARK: -Extension Configure tableViewController
extension HomeVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: COUNTRY_CELLID, for: indexPath)
        cell.textLabel?.text = countries?[indexPath.row] ?? ""
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CountryDetailsVC()
        vc.country = countries?[indexPath.row] ?? ""
        navigationController?.pushViewController(vc, animated: true)
    }
}
