//
//  TitleCell.swift
//  PlanDo
//
//  Created by donghun on 2023/02/12.
//

import UIKit
import SnapKit

class TitleCell: UICollectionViewCell {
    // 할일 타이틀
    private lazy var titleTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "할일을 등록하세요."
        //textField.backgroundColor = .systemPink
        textField.layer.cornerRadius = 15
        textField.backgroundColor = .systemPink
        return textField
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(titleTextField)
        
        
        titleTextField.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
}
