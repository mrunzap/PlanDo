//
//  AddButton.swift
//  PlanDo
//
//  Created by donghun on 2023/02/25.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class AddButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute(){
        self.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        let configuration = UIImage.SymbolConfiguration(pointSize: 1000)
        self.setPreferredSymbolConfiguration(configuration, forImageIn: .normal)
        self.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    @objc func addButtonTapped(){
        print("addButtonTapped!")
    }
}
