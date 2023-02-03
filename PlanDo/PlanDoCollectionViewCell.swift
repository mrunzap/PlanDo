//
//  PlanDoCollectionViewCell.swift
//  
//
//  Created by donghun on 2023/01/27.
//

import UIKit
import SnapKit

class PlanDoCollectionViewCell : UICollectionViewCell {
 
    let titleLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(titleLabel)
        titleLabel.text = "vue.js 학습하기"
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(contentView.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
    }
}
