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
    var titleLabel:((_ title: String) ->Void)?
    
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
        titleTextField.delegate = self
        contentView.addSubview(titleTextField)
        titleTextField.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
}

extension TitleCell : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        self.titleLabel?(text)
    }
}
