//
//  CountryDetailsVC.swift
//  MuslimAssisstantAssessment
//
//  Created by Abo-Aljoud94 on 1/20/21.
//

import UIKit

class CountryDetailsVC: UIViewController {
    // MARK: -Properties
    var country: String?
    var countryStatistics: CountryStatistics? {
        didSet {
            fillStatistics()
        }
    }
    
    // MARK: -LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayOut()
        fetchCountryDetails()
    }
    
    // MARK: -APICalls
    func fetchCountryDetails(){
        guard let country = country else { return }
        APIManager.shared.getCountryDetails(countryName: country) { [weak self](res) in
            switch res {
            case .success(let countryStatistics):
                self?.countryStatistics = countryStatistics
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: -Helpers
    func fillStatistics(){
        
    }
    
    // MARK: -setUpLayOut
    func setUpLayOut(){
        view.backgroundColor = .white
        configureLabelsStack()
        addCasesView()
        addDeathsTestsStatisticsView()
    }
    
    func configureLabelsStack(){
        svLabelsStack.addArrangedSubview(lbCountryName)
        svLabelsStack.addArrangedSubview(lbInformationUpdated)
        view.addSubview(svLabelsStack)
        svLabelsStack.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConst: 60, leftConst: 16, bottomConst: 0, rightConst: 0, width: 300, height: 50)
    }
    
    func addCasesView(){
        view.addSubview(casesStatisticView)
        casesStatisticView.anchor(top: svLabelsStack.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConst: 20, leftConst: 16, bottomConst: 0, rightConst: -16, width: 0, height: view.frame.height * 0.2)
        
//        let ss = [Statistic(title: "Total", detail: "32165465"), Statistic(title: "Active", detail: "654654")]
//
//        casesStatisticView.statistics = ss
//        casesStatisticView.setUpStatisticDetailViews()
        
    }
    
    func addDeathsTestsStatisticsView(){
        svStatisticsStack.addArrangedSubview(deathsStatisticView)
        svStatisticsStack.addArrangedSubview(testsStatisticView)
        
        view.addSubview(svStatisticsStack)
        svStatisticsStack.anchor(top: casesStatisticView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConst: 10, leftConst: 16, bottomConst: 0, rightConst: -16, width: 0, height: view.frame.height * 0.2)
        
    }
    
    // MARK: -UIElements
    let lbCountryName: UILabel = {
        let lb = UILabel()
        lb.text = "COVID 19 statistic in SADGSAG"
        return lb
    }()
    
    let lbInformationUpdated: UILabel = {
        let lb = UILabel()
        lb.text = "last update: \(Date())"
        return lb
    }()
    
    let svLabelsStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 10
        return sv
    }()
    
    let casesStatisticView: CountryStatisticView = {
        let vi = CountryStatisticView()
        vi.layer.cornerRadius = 10
        vi.layer.borderWidth = 0.5
        vi.layer.borderColor = UIColor.lightGray.cgColor
        return vi
    }()
    
    let deathsStatisticView: CountryStatisticView = {
        let vi = CountryStatisticView()
        vi.layer.borderWidth = 0.5
        vi.layer.borderColor = UIColor.lightGray.cgColor
        return vi
    }()
    
    let testsStatisticView: CountryStatisticView = {
        let vi = CountryStatisticView()
        vi.layer.borderWidth = 0.5
        vi.layer.borderColor = UIColor.lightGray.cgColor
        return vi
    }()
    
    let svStatisticsStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 16
        sv.distribution = .fillEqually
        return sv
    }()
    
    
}
