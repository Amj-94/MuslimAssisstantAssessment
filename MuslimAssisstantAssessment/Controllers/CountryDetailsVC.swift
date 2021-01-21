//
//  CountryDetailsVC.swift
//  MuslimAssisstantAssessment
//
//  Created by Abo-Aljoud94 on 1/20/21.
//

import UIKit

class CountryDetailsVC: UIViewController {
    // MARK: -Properties
    var country: String = ""
    
    // MARK: -LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayOut()
        APIManager.shared.getCountryDetails(countryName: country) { (res) in
            
        }
    }
    
    // MARK: -setUpLayOut
    func setUpLayOut(){
        view.backgroundColor = .blue
    }
    
    // MARK: -Controls
}
