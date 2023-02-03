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
    private lazy var dateStackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 8
        return stack
    }()
    
    private lazy var toolBar: UIToolbar = {
        let toolbar = UIToolbar()
        let cancelBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: nil)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let titleBarButtonItem = UIBarButtonItem(title: "할일 추가", style: .plain, target: self, action: nil)
        let saveBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: nil)

        var items = [UIBarButtonItem]()
        [cancelBarButtonItem,flexibleSpace,titleBarButtonItem,flexibleSpace,saveBarButtonItem].forEach {
            $0.tintColor = .green
            items.append($0)
        }

        toolbar.setItems(items, animated: true)
        return toolbar
    }()

    
    // 할일 타이틀
    //TODO - underLine추가하기[x]
    private lazy var titleTextField : UITextField = {
        let textField = UITextField()
        textField.text = "점심먹기"
//        textField.layer.borderWidth = 1
//        textField.layer.borderColor = CGColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
//        textField.layer.cornerRadius = 0.5
        return textField
    }()
    
    // 시작일
    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("시작일", for: .normal)
        button.tintColor = .black
        button.setTitleColor(.black, for: .normal)
        //button.layer.borderWidth = 1
        //button.layer.borderColor = CGColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        //button.layer.cornerRadius = 0.5
        button.addTarget(self, action: #selector(startDateButtonTapped) ,for: .touchUpInside)
        return button
    }()
    
    // 종료일
    private lazy var endButton: UIButton = {
        let button = UIButton()
        button.setTitle("종료일", for: .normal)
        button.setTitleColor(.black, for: .normal)
        //button.layer.borderWidth = 1
        //button.layer.borderColor = CGColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        //button.layer.cornerRadius = 0.5
        button.addTarget(self, action: #selector(endDateButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // 메모
    private lazy var discriptionTextField: UITextField = {
        let textField = UITextField()
        textField.text = "메모추가"
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addView()
    }
    
    private func addView(){
        
        view.addSubview(entireStackView)
        
        entireStackView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        entireStackView.addSubview(toolBar)
        

        entireStackView.addSubview(titleTextField)
        entireStackView.addSubview(dateStackView)
        
        dateStackView.addSubview(startButton)
        dateStackView.addSubview(endButton)
        
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
        
        entireStackView.addSubview(discriptionTextField)
        
        toolBar.snp.makeConstraints {
            $0.top.trailing.leading.equalTo(entireStackView.safeAreaLayoutGuide)
            $0.height.equalTo(70)
        }
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(toolBar.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(70)
        }
        
        dateStackView.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(70)
        }
        
        discriptionTextField.snp.makeConstraints {
            $0.top.equalTo(dateStackView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(endButton.safeAreaLayoutGuide)
        }
    }
    
    // 시작일 버튼 이벤트
    @objc func startDateButtonTapped(){
        
    }
    
    // 종료일 버튼 이벤트
    @objc func endDateButtonTapped(){
        
    }
}
