//
//  ImportantButton.swift
//  PlanDo
//
//  Created by donghun on 2023/02/18.
//

import UIKit
import SnapKit

class ImportantButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setImage(UIImage(systemName: "star"), for: .normal)
        addTarget(self, action: #selector(tapButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tapButton(){
        setImage(UIImage(systemName: "star.fill"), for: .selected)
    }
}
