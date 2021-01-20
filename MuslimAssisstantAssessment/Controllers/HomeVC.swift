//
//  HomeVC.swift
//  MuslimAssisstantAssessment
//
//  Created by Abo-Aljoud94 on 1/20/21.
//

import UIKit

class HomeVC: UITableViewController {
    // MARK: -properties
    
    // MARK: -LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayOut()
    }
    
    // MARK: -setUpLayOut
    func setUpLayOut() {
        setUpTableView()
    }
    
    func setUpTableView() {
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CountryCellId")
        tableView.rowHeight = 60
    }
    
    // MARK: -Controls
    
}

// MARK: -Extension Configure tableViewController
extension HomeVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCellId", for: indexPath)
        cell.textLabel?.text = "Test"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CountryDetailsVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}
