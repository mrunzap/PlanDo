//
//  TitleView.swift
//  PlanDo
//
//  Created by donghun on 2023/03/21.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit
class TitleCell: UITableViewCell {
    let disposeBag = DisposeBag()
    let starButton = StarButton()
    let titleTextField = UITextField()
    let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        attribute()
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: TitleCellViewModel) {
      
    }

    private func attribute() {
        titleTextField.font = .systemFont(ofSize: 20)
        titleTextField.borderStyle = .roundedRect
        titleLabel.text = "Have To Do a Thing"
        titleLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        titleLabel.textColor = .systemGray
    }
    private func layout() {
        [starButton,titleLabel,titleTextField].forEach {
            contentView.addSubview($0)
        }
        starButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo(70)
            $0.width.equalTo(70)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalTo(starButton.snp.trailing)
            $0.height.equalTo(40)
        }
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.equalTo(starButton.snp.trailing)
            $0.trailing.equalToSuperview().inset(12)
        }
    }
}
