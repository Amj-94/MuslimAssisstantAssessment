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
    var countryStatistics: Response? {
        didSet {
            setUplbInformationUpdatedText()
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
                self?.countryStatistics = countryStatistics.response[0]
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: -Helpers
    func fillStatistics(){
        guard let response = countryStatistics else { return }
        casesCardView.details = fillCasesDetails(object: response)
        deathsCardView.details = fillDethesDetails(object: response)
        testsCardView.details = fillTestsDetails(object: response)
    }
    
    func fillCasesDetails(object: Response) -> [String] {
        var values = [String]()
        if let active = object.cases.active {
            values.append(String(active))
        } else {
            values.append("NA")
        }
        
        if let critical = object.cases.critical {
            values.append(String(critical))
        } else {
            values.append("NA")
        }
        
        if let recovered = object.cases.recovered {
            values.append(String(recovered))
        } else {
            values.append("NA")
        }
        values.append(String(object.cases.total))
        return values
    }
    
    func fillDethesDetails(object: Response) -> [String] {
        let new = object.deaths.new ?? "NA"
        let total = String(object.deaths.total)
        return [new, total]
    }
    
    func fillTestsDetails(object: Response) -> [String] {
        let total = String(object.tests.total)
        return [total]
    }
    
    // MARK: -setUpLayOut
    func setUpLayOut(){
        view.backgroundColor = .white
        configureLabelsStack()
        addCasesView()
        addDeathsTestsView()
    }
    
    func configureLabelsStack(){
        svLabelsStack.addArrangedSubview(lbCountryName)
        svLabelsStack.addArrangedSubview(lbInformationUpdated)
        view.addSubview(svLabelsStack)
        svLabelsStack.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConst: 60, leftConst: 16, bottomConst: 0, rightConst: -16, width: 0, height: 50)
        setUplbCountryNameText()
    }
    
    func addCasesView(){
        view.addSubview(casesCardView)
        casesCardView.anchor(top: svLabelsStack.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConst: 20, leftConst: 16, bottomConst: 0, rightConst: -16, width: 0, height: view.frame.height * 0.2)
        
        let titles = ["active", "critical", "recovered", "total"]
        casesCardView.label = "Cases"
        casesCardView.titles = titles
        casesCardView.setUpLayOut()
        
    }
    
    func addDeathsTestsView(){
        svCardsStack.addArrangedSubview(deathsCardView)
        svCardsStack.addArrangedSubview(testsCardView)
        
        view.addSubview(svCardsStack)
        svCardsStack.anchor(top: casesCardView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConst: 10, leftConst: 16, bottomConst: 0, rightConst: -16, width: 0, height: view.frame.height * 0.2)
        
        let deathCardtitles = ["new", "total"]
        deathsCardView.label = "Deathes"
        deathsCardView.titles = deathCardtitles
        deathsCardView.setUpLayOut()
        
        let testsCardTitles = ["total"]
        testsCardView.label = "Tests"
        testsCardView.titles = testsCardTitles
        testsCardView.setUpLayOut()
    }
    
    func setUplbCountryNameText() {
        let attributString = NSMutableAttributedString(string: "COVID-19 Statistics in ", attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.darkGray])
        
        
        guard let country = country else { return }
        
        attributString.append(NSMutableAttributedString(string: country, attributes: [.font: UIFont.boldSystemFont(ofSize: 18), .foregroundColor: UIColor.darkGray]))
        lbCountryName.attributedText = attributString
    }
    
    func setUplbInformationUpdatedText(){
        guard let date = countryStatistics?.time else { return }
        
        // The date returned from the api does'nt conform to Swift Date
        // so I converted it to Swift Date then converted it to String
        
        // another format: "yyyy-MM-dd'T'HH:mm:ssZ"
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm E, d MMM y"
        if let swiftDate = formatter.date(from:date) {
            lbInformationUpdated.text! += formatter.string(from: swiftDate)
        } else {
            lbInformationUpdated.text! += formatter.string(from: Date())
        }
    }
    
    // MARK: -UIElements
    let lbCountryName: UILabel = {
        let lb = UILabel()
        return lb
    }()
    
    let lbInformationUpdated: UILabel = {
        let lb = UILabel()
        lb.text = "last update "
        lb.textColor = .gray
        lb.font = .systemFont(ofSize: 16)
        return lb
    }()
    
    let svLabelsStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 10
        return sv
    }()
    
    let casesCardView: StatisticCardView = {
        let vi = StatisticCardView()
        vi.layer.borderWidth = 0.5
        vi.layer.borderColor = UIColor.lightGray.cgColor
        return vi
    }()
    
    let deathsCardView: StatisticCardView = {
        let vi = StatisticCardView()
        vi.layer.borderWidth = 0.5
        vi.layer.borderColor = UIColor.lightGray.cgColor
        return vi
    }()
    
    let testsCardView: StatisticCardView = {
        let vi = StatisticCardView()
        vi.layer.borderWidth = 0.5
        vi.layer.borderColor = UIColor.lightGray.cgColor
        return vi
    }()
    
    let svCardsStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 16
        sv.distribution = .fillEqually
        return sv
    }()
    
    
}
