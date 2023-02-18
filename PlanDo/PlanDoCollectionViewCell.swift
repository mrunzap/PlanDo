//
//  PlanDoCollectionViewCell.swift
//  
//
//  Created by donghun on 2023/01/27.
//

import UIKit
import SnapKit

enum ImportantPlanDoRatio {
    case high
    case medium
    case low
}
class PlanDoCollectionViewCell : UICollectionViewCell {
    
    
    var stackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 8
        //stack.backgroundColor = .systemPink
        stack.layer.cornerRadius = 20
        return stack
    }()
    
    var titleLabel: UILabel = {
        let title = UILabel()
        //title.backgroundColor = .systemPink
        title.font = .systemFont(ofSize: 20, weight: .medium)
        return title
    }()
    
    var dateLabel: UILabel = {
        let title = UILabel()
        //title.backgroundColor = .systemPink
        title.font = .systemFont(ofSize: 17, weight: .light)
        return title
    }()
    
    var importantView: UIView = {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 70, height: 70)))
        view.backgroundColor = .red
        view.layer.cornerRadius = 15
        
        return view
    }()
    // 중요도
    let importantButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        let configuration = UIImage.SymbolConfiguration(pointSize: 30)
        button.setPreferredSymbolConfiguration(configuration, forImageIn: .normal)
        //button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    let button: UIButton = {
        let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 70, height: 70)))
        button.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        let configuration = UIImage.SymbolConfiguration(pointSize: 35)
        button.setPreferredSymbolConfiguration(configuration, forImageIn: .normal)
        //button.backgroundColor = .blue
       // button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [importantButton,stackView,button].forEach {
            contentView.addSubview($0)
        }
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(dateLabel)
        importantButton.snp.makeConstraints {
            $0.top.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            $0.leading.equalToSuperview().inset(10)
            $0.width.equalTo(70)
            $0.centerY.equalTo(contentView.snp.centerY)
        }
        stackView.snp.makeConstraints {
            $0.centerY.equalTo(importantButton)
            $0.leading.equalTo(importantButton.snp.trailing).offset(10)
            $0.trailing.equalTo(button.snp.leading)
            
        }
        button.snp.makeConstraints {
            $0.centerY.equalTo(importantButton)
            $0.trailing.equalTo(contentView.snp.trailing)
            $0.width.equalTo(70)
        }
    }
    func updasteUI(planDo: PlanDo){
        print("cell:\(planDo)")
        titleLabel.text = planDo.title
        dateLabel.text = "\(planDo.startDate) ~ \(planDo.endDate)"
        if planDo.isStar {
            importantButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            importantButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
        
    }
}
