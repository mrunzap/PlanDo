//
//  DetailCell.swift
//  PlanDo
//
//  Created by donghun on 2023/03/21.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
class DetailCell: UITableViewCell {
    let disposeBag = DisposeBag()
    let contentLabel = UILabel()
    let contentInputView = UITextView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: DetailViewModel) {
        contentInputView.rx.text
            .bind(to: viewModel.contentValue)
            .disposed(by: disposeBag)
    }

    private func attribute() {
        contentLabel.text = "메모"
        contentLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        contentLabel.textColor = .systemGray
        
        contentInputView.font = .systemFont(ofSize: 17)
    }
    
    private func layout() {
        
        [contentLabel,contentInputView].forEach {
            contentView.addSubview($0)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(12)
            $0.height.equalTo(40)
            $0.width.equalToSuperview()
        }
        
        contentInputView.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(12)
            $0.height.equalTo(500)
        }
    }
}
