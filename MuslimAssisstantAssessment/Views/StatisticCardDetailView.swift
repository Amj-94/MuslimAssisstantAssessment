//
//  StatisticDetailView.swift
//  MuslimAssisstantAssessment
//
//  Created by Abo-Aljoud94 on 1/21/21.
//

import UIKit

class StatisticCardDetailView: UIView {
    // MARK: -properties
    var title: String?
    var detail: String?
    
    
    // MARK: -init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -setUpLayOut
    func setUpLayOut(){
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        let stack = UIStackView(arrangedSubviews: [lbTitle, lbDetail])
        stack.axis = .vertical
        stack.spacing = 10
        
        addSubview(stack)
        stack.centerX(inView: self)
        stack.centerY(inView: self)
        
        lbTitle.text = title ?? ""
        lbDetail.text = detail ?? ""
        
    }
    
    // MARK: -UIElements
    let lbTitle: UILabel = {
        let lb = UILabel()
        return lb
    }()
    
    let lbDetail: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 8)
        return lb
    }()
    
    
}
