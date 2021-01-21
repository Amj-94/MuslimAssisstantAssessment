//
//  CountryStatisticView.swift
//  MuslimAssisstantAssessment
//
//  Created by Abo-Aljoud94 on 1/21/21.
//

import UIKit

class StatisticCardView: UIView {
    // MARK: -Properties
    var label: String?
    var titles: [String]?
    var details: [String]? {
        didSet {
            fillDetails()
        }
    }
    var detailsViews = [StatisticCardDetailView]()
    
    // MARK: -Init
    override init(frame: CGRect) {
        super.init(frame: frame)
//        setUpLayOut()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Helpers
    func fillDetails(){
        guard let details = details else { return }
        if details.count == detailsViews.count {
            for i in 0...detailsViews.count - 1{
                detailsViews[i].detail = details[i]
            }
        }
    }
    
    // MARK: -setUpLayOut
    func setUpLayOut(){
        backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        setUpTopView()
        setUpStatisticDetailViews()
    }
    
    func setUpTopView(){
        addSubview(viTopView)
        viTopView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConst: 0, leftConst: 0, bottomConst: 0, rightConst: 0, width: 0, height: 0)
        viTopView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25).isActive = true
        
        viTopView.addSubview(lbStatisticLabel)
        lbStatisticLabel.anchor(top: viTopView.topAnchor, left: viTopView.leftAnchor, bottom: nil, right: nil, topConst: 6, leftConst: 8, bottomConst: 0, rightConst: 0, width: 0, height: 0)
        lbStatisticLabel.centerY(inView: viTopView)
        
    }
    
    func setUpStatisticDetailViews(){
        addSubview(viContainerView)
        viContainerView.anchor(top: viTopView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConst: 0, leftConst: 0, bottomConst: 0, rightConst: 0, width: 0, height: 0)
        guard let titles = titles else { return }
        for title in titles {
            let detailView = StatisticCardDetailView()
            detailView.title = title
            detailView.setUpLayOut()
            detailsViews.append(detailView)
        }
            
        let detailsStack = UIStackView(arrangedSubviews: detailsViews)
        detailsStack.axis = .horizontal
        detailsStack.spacing = 6
        detailsStack.distribution = .fillEqually
        viContainerView.addSubview(detailsStack)
        detailsStack.centerX(inView: viContainerView)
        detailsStack.centerY(inView: viContainerView)
        detailsStack.anchor(top: nil, left: viContainerView.leftAnchor, bottom: nil, right: viContainerView.rightAnchor, topConst: 0, leftConst: 8, bottomConst: 0, rightConst: -8, width: 0, height: 0)
        
    }
    
    func addSeparetor() -> UIView {
        let vi = UIView()
        vi.backgroundColor = .lightGray
        return vi
    }
    
    // MARK: -UIElements
    
    let viTopView: UIView = {
        let vi = UIView()
        vi.backgroundColor = .gray
        return vi
    }()
    
    let lbStatisticLabel: UILabel = {
        let lb = UILabel()
        lb.text = "asdfuhsa"
        return lb
    }()
    
    let viContainerView: UIView = {
        let vi = UIView()
        return vi
    }()
}
