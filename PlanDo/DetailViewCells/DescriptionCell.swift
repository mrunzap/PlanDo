//
//  DescriptionCell.swift
//  PlanDo
//
//  Created by donghun on 2023/02/12.
//

import UIKit
import SnapKit

class DescriptionCell: UICollectionViewCell {
    // 할일 타이틀
    private lazy var titleTextView : UITextView = {
        let frame = CGRect(x: 0, y: 0, width: contentView.bounds.width, height: 800)
        let textView = UITextView(frame: frame)
        textView.backgroundColor = .systemPink
        textView.layer.cornerRadius = 15
        textView.backgroundColor = .systemTeal

        return textView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(titleTextView)
        
        
        titleTextView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.trailing.bottom.equalToSuperview().inset(20)
            $0.height.equalTo(400)
        }
    }
}
