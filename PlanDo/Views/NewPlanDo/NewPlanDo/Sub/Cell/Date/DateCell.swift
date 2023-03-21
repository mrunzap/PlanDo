//
//  DateCell.swift
//  PlanDo
//
//  Created by donghun on 2023/03/21.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit
class DateCell: UITableViewCell {
    let disposeBag = DisposeBag()
    // 중요도
    let startDateButton = UIButton()
    let endDateButton = UIButton()
    let startLabel = UILabel()
    let endLabel = UILabel()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        attribute()
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: DateCellViewModel) {
        self.startDateButton.rx.tap
            .map { [weak self] _ -> Date in
                guard let self = self,
                      let startDate = self.startDateButton.titleLabel?.text else { return Date()}
                return self.convertStringToDate(stringDate: startDate)
            }
            .bind(to: viewModel.startDateButtonTapped)
            .disposed(by: disposeBag)
        
        self.endDateButton.rx.tap
            .map { [weak self] _ -> Date in
                guard let self = self,
                      let endDate = self.endDateButton.titleLabel?.text else { return Date()}
                return self.convertStringToDate(stringDate: endDate)
            }
            .bind(to: viewModel.endDateButtonTapped)
            .disposed(by: disposeBag)
    }
    func convertStringToDate(stringDate: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        return dateFormatter.date(from: stringDate) ?? Date()
    }
    private func attribute() {
        startLabel.text = "시작일"
        startLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        startLabel.textColor = .systemGray
        
        endLabel.text = "종료일"
        endLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        endLabel.textColor = .systemGray

        startDateButton.setTitleColor(.orange, for: .normal)
        startDateButton.setImage(UIImage(systemName: "calendar"), for: .normal)
        startDateButton.setTitle("2022-01-01", for: .normal)
        startDateButton.titleLabel?.font = .systemFont(ofSize: 18)
        startDateButton.tintColor = .orange
        startDateButton.backgroundColor = .white
        startDateButton.layer.borderColor = UIColor.orange.cgColor
        startDateButton.layer.borderWidth = 1.0
        startDateButton.layer.cornerRadius = 10.0
        startDateButton.clipsToBounds = true
        startDateButton.semanticContentAttribute = .forceLeftToRight
        
        endDateButton.setTitleColor(.orange, for: .normal)
        endDateButton.setImage(UIImage(systemName: "calendar"), for: .normal)
        endDateButton.setTitle("2022-12-12", for: .normal)
        endDateButton.titleLabel?.font = .systemFont(ofSize: 18)
        endDateButton.tintColor = .orange
        endDateButton.backgroundColor = .white
        endDateButton.layer.borderColor = UIColor.orange.cgColor
        endDateButton.layer.borderWidth = 1.0
        endDateButton.layer.cornerRadius = 10.0
        endDateButton.clipsToBounds = true
        endDateButton.semanticContentAttribute = .forceLeftToRight
    }
    private func layout() {
        [startLabel,endLabel,startDateButton,endDateButton].forEach {
            contentView.addSubview($0)
            
        }
        
        startLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(12)
            $0.height.equalTo(40)
            $0.width.equalToSuperview().dividedBy(2)
        }
        endLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.height.equalTo(40)
            $0.leading.equalTo(startLabel.snp.trailing)
            $0.trailing.equalToSuperview()
        }
        startDateButton.snp.makeConstraints {
            $0.top.equalTo(startLabel.snp.bottom)
            $0.height.equalTo(40)
            $0.leading.equalToSuperview().inset(12)
            $0.width.equalTo((UIScreen.main.bounds.width/2) - 12)
        }
        endDateButton.snp.makeConstraints {
            $0.top.equalTo(endLabel.snp.bottom)
            $0.height.equalTo(40)
            $0.leading.equalTo(startLabel.snp.trailing)
            $0.trailing.equalToSuperview().inset(12)
        }
    }
}
