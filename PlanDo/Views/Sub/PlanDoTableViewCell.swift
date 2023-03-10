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
class PlanDoTableViewCell : UITableViewCell {
    
    let stackView = UIStackView()
    let titleLabel = UILabel()
    let dateLabel = UILabel()
    let importantView = UIView()
    let importantButton = UIButton()
    let checkButton = UIButton()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        attribute()
        layout()
    }
    
    private func attribute(){
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        stackView.layer.cornerRadius = 20
        titleLabel.font = .systemFont(ofSize: 20, weight: .medium)
        titleLabel.font = .systemFont(ofSize: 17, weight: .light)
        importantView.backgroundColor = .red
        importantView.layer.cornerRadius = 15
        let button = UIButton()
        importantButton.setImage(UIImage(systemName: "star"), for: .normal)
        let configuration = UIImage.SymbolConfiguration(pointSize: 30)
        importantButton.setPreferredSymbolConfiguration(configuration, forImageIn: .normal)
        checkButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        let checkConfiguration = UIImage.SymbolConfiguration(pointSize: 35)
        checkButton.setPreferredSymbolConfiguration(checkConfiguration, forImageIn: .normal)
    }
    
    private func layout(){
        [importantButton,stackView,checkButton].forEach {
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
            $0.trailing.equalTo(checkButton.snp.leading)
            
        }
        checkButton.snp.makeConstraints {
            $0.centerY.equalTo(importantButton)
            $0.trailing.equalTo(contentView.snp.trailing)
            $0.width.equalTo(70)
        }
    }
    func setData(planDo: PlanDo){
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
