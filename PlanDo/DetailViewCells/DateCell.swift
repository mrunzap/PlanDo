//
//  DateCell.swift
//  PlanDo
//
//  Created by donghun on 2023/02/12.
//

import UIKit
import SnapKit

class DateCell: UICollectionViewCell {
    // 할일 타이틀
    private lazy var titleTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "여기는 시작딜과 종료일 등록하는곳"
        //textField.backgroundColor = .systemPink
        textField.layer.cornerRadius = 15
        textField.backgroundColor = .systemBlue
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
