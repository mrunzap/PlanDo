//
//  NewPlanDoViewController.swift
//  PlanDo
//
//  Created by donghun on 2023/02/03.
//

import UIKit
import SnapKit
import SkyFloatingLabelTextField

class NewPlanDoViewController: UIViewController {
    
    // 전체 스택뷰
    private lazy var entireStackView : UIStackView = {
        let stack = UIStackView()
        stack.spacing = 0.8
        stack.axis = .vertical
        return stack
    }()
    
    // 시작일 종료일 담는 스택뷰
    private lazy var entireDateStackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 8
        return stack
    }()
    
    // 시작일 종료일 담는 스택뷰
    private lazy var dateStackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 8
        return stack
    }()
    
    private lazy var toolBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        
        let item = UINavigationItem()
        item.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonTapped))
        item.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: nil)

        item.title = "할일 추가"
        navigationBar.setItems([item], animated: true)
        return navigationBar
    }()

    
    // 할일 타이틀
    //TODO - underLine추가하기[x]
    private lazy var titleTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "할일을 등록하세요."
        textField.backgroundColor = .groupTableViewBackground
        return textField
    }()
    
    // 시작일
    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("시작일", for: .normal)

        button.tintColor = .black
        button.setTitleColor(.black, for: .normal)
        
        button.addTarget(self, action: #selector(startDateButtonTapped) ,for: .touchUpInside)
        return button
    }()
    
    // 종료일
    private lazy var endButton: UIButton = {
        let button = UIButton()
        button.setTitle("종료일", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(endDateButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // 메모
    private lazy var discriptionTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "메모 등록하세요."
        textField.backgroundColor = .groupTableViewBackground
        return textField
    }()
    
    // DatePicker
    
    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .inline
        picker.datePickerMode = .date
        picker.contentMode = .scaleAspectFill
        picker.layer.isHidden = true
        return picker
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addView()
    }
    
    private func addView(){
        
        view.addSubview(entireStackView)
        entireStackView.addSubview(toolBar)
        entireStackView.addSubview(titleTextField)
        entireStackView.addSubview(entireDateStackView)
        entireDateStackView.addSubview(dateStackView)
        dateStackView.addSubview(startButton)
        dateStackView.addSubview(endButton)
        entireDateStackView.addSubview(datePicker)
        entireDateStackView.addSubview(discriptionTextField)
        
        entireStackView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        toolBar.snp.makeConstraints {
            $0.top.trailing.leading.equalTo(entireStackView.safeAreaLayoutGuide)
            $0.height.equalTo(70)
        }
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(toolBar.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(70)
        }
        
        entireDateStackView.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(view.safeAreaLayoutGuide)
        }
        
        dateStackView.snp.makeConstraints {
            $0.top.equalTo(entireDateStackView.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(70)
        }
        
        startButton.snp.makeConstraints {
            $0.top.equalTo(dateStackView.safeAreaLayoutGuide)
            $0.leading.equalToSuperview()
            $0.width.equalTo(dateStackView.snp.width).dividedBy(2)
            $0.height.equalToSuperview()
        }
        
        endButton.snp.makeConstraints {
            $0.top.equalTo(dateStackView.safeAreaLayoutGuide)
            $0.leading.equalTo(startButton.snp.trailing)
            $0.width.equalTo(dateStackView.snp.width).dividedBy(2)
            $0.height.equalToSuperview()
        }
        datePicker.snp.makeConstraints {
            $0.top.equalTo(startButton.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.width.equalToSuperview().inset(20)
            $0.height.equalTo(0)
        }

        
       
        discriptionTextField.snp.makeConstraints {
            $0.top.equalTo(datePicker.snp.bottom).inset(-20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(entireDateStackView.safeAreaLayoutGuide)
        }
    }
    
    // 시작일 버튼 이벤트
    @objc func startDateButtonTapped(){
        startButton.isSelected = !startButton.isSelected
       
        datePicker.layer.isHidden = startButton.isSelected ? false: true

        datePicker.snp.updateConstraints {
            $0.top.equalTo(startButton.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.width.equalToSuperview().inset(20)
            $0.height.equalTo(startButton.isSelected ? 350 : 0)
        }
    }
    
    // 종료일 버튼 이벤트
    @objc func endDateButtonTapped(){
        endButton.isSelected = !endButton.isSelected
       
        datePicker.layer.isHidden = endButton.isSelected ? false: true

        datePicker.snp.updateConstraints {
            $0.top.equalTo(startButton.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.width.equalToSuperview().inset(20)
            $0.height.equalTo(endButton.isSelected ? 350 : 0)
        }
    }
    
    // 취소버튼 이벤트
    @objc func cancelButtonTapped(){
        self.dismiss(animated: true)
    }
}
