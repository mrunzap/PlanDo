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
        titleLabel.backgroundColor = .yellow
        contentView.backgroundColor = .red
        titleLabel.text = "zzzzzzzzzzzzzzzzzzzzzz"
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }
    }
}
