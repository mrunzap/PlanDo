//
//  StarButton.swift
//  PlanDo
//
//  Created by donghun on 2023/03/21.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
class StarButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute(){
        self.setImage(UIImage(systemName: "star"), for: .normal)
        let configuration = UIImage.SymbolConfiguration(pointSize: 30)
        self.setPreferredSymbolConfiguration(configuration, forImageIn: .normal)
        //self.backgroundColor = .blue
        
    }
    
    private func layout(){
        
    }
}
    
