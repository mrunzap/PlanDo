//
//  PlanDoCollectionViewHeader.swift
//  PlanDo
//
//  Created by donghun on 2023/01/30.
//

import UIKit
import FSCalendar
import SnapKit
import RxGesture
import RxCocoa
import RxSwift
enum dayName {
    case today
    case yesterday
}
class PlanDoTableViewHeader: UITableViewHeaderFooterView {
    
    let label :UILabel = {
        let label = UILabel()
        label.text = "컬렉션뷰 헤더"
        label.backgroundColor = .red
        return label
    }()
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .black
        addSubview(label)
        
        label.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
}
