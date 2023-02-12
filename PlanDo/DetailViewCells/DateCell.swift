//
//  DateCell.swift
//  PlanDo
//
//  Created by donghun on 2023/02/12.
//  History:
//  1.버튼 토글 기능에서 시작일 클릭했을 때 datePㅑㅊㄷㄱ
//

import UIKit
import SnapKit

class DateCell: UICollectionViewCell {
    //TODO: 2023.02.13
    // >시작 종료일 버튼 토글 기능
    // >>dataPicerView생성
    // >>>PlanDO객체로 변환
    // >>>>최종 저장확인

    // 시작일 종료일 담는 스택뷰
    private lazy var entireDateStackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 8
        return stack
    }()
    
    // 시작일 종료일 담는 스택뷰
    private lazy var startStackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 2
        stack.backgroundColor = .blue
        stack.layer.cornerRadius = 15
        return stack
    }()
    // 시작일 종료일 담는 스택뷰
    private lazy var endStackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 2
        stack.backgroundColor = .blue
        stack.layer.cornerRadius = 15
        return stack
    }()

    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("시작일", for: .normal)

        button.tintColor = .black
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    // 종료일
    private lazy var endButton: UIButton = {
        let button = UIButton()
        button.setTitle("종료일", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    private lazy var startDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .automatic
        picker.datePickerMode = .date
        picker.contentMode = .scaleToFill
        picker.layer.cornerRadius = 15
        picker.locale = Locale(identifier: "ko")
        picker.addTarget(self, action: #selector(startDateTapped(_ :)), for: .valueChanged)
        return picker
    }()
    private lazy var endDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .automatic
        picker.datePickerMode = .date
        picker.contentMode = .scaleToFill
        picker.layer.cornerRadius = 15
        picker.locale = Locale(identifier: "ko")
        picker.addTarget(self, action: #selector(endDateTapped(_ :)), for: .valueChanged)
        return picker
    }()
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(entireDateStackView)
        entireDateStackView.addArrangedSubview(startStackView)
        entireDateStackView.addArrangedSubview(endStackView)
        startStackView.addArrangedSubview(startButton)
        startStackView.addArrangedSubview(startDatePicker)
        endStackView.addArrangedSubview(endButton)
        endStackView.addArrangedSubview(endDatePicker)
        entireDateStackView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview().inset(20)
        }
    }
    
    @objc func startDateTapped(_ sender: UIDatePicker) {
        print(sender.date)
    }
    
    @objc func endDateTapped(_ sender: UIDatePicker) {
        
    }
}
