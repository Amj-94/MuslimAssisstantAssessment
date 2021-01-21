//
//  CountryStatisticView.swift
//  MuslimAssisstantAssessment
//
//  Created by Abo-Aljoud94 on 1/21/21.
//

import UIKit

struct Statistic {
    let title: String
    let detail: String
}

class CountryStatisticView: UIView {
    // MARK: -Properties
    var label: String?
    var statistics: [Statistic]?
    
    // MARK: -Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayOut()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -setUpLayOut
    func setUpLayOut(){
        backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        setUpTopView()
        setUpStatisticDetailViews()
    }
    
    func setUpTopView(){
        addSubview(viTopView)
        viTopView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConst: 0, leftConst: 0, bottomConst: 0, rightConst: 0, width: 0, height: 0)
        viTopView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25).isActive = true
        
        viTopView.addSubview(lbStatisticLabel)
        lbStatisticLabel.anchor(top: viTopView.topAnchor, left: viTopView.leftAnchor, bottom: nil, right: nil, topConst: 6, leftConst: 6, bottomConst: 0, rightConst: 0, width: 0, height: 0)
        lbStatisticLabel.centerY(inView: viTopView)
        
    }
    
    func setUpStatisticDetailViews(){
        if let statistics = statistics{
            var views = [UIView]()
            for statistic in statistics {
                let statisticDetail = StatisticDetailView()
                statisticDetail.statistic = statistic
                statisticDetail.setUpLayOut()
                views.append(statisticDetail)
            }
            
            let detailsStack = UIStackView(arrangedSubviews: views)
            detailsStack.axis = .horizontal
            detailsStack.spacing = 6
            detailsStack.distribution = .fillEqually
            addSubview(detailsStack)
            detailsStack.centerX(inView: self)
            detailsStack.centerY(inView: self)
            detailsStack.anchor(top: nil, left: leftAnchor, bottom: nil, right: rightAnchor, topConst: 0, leftConst: 8, bottomConst: 0, rightConst: -6, width: 0, height: 0)
        }
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
}