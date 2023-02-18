//
//  NewPlanView.swift
//  PlanDo
//
//  Created by donghun on 2023/02/18.
//

import UIKit
import SnapKit
import Kingfisher
import RxCocoa
import RxSwift
protocol NewPlanViewSaveDelegate: AnyObject {
    func didSelectReigster()
}
class NewPlanView: UIViewController {
    
    let viewModel = PlanDoViewModel()
    weak var delegate: NewPlanViewSaveDelegate?
    // 시작일 종료일 픽업뷰 감ㅈ싸는 스택뷰
    var dateStackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 8
        stack.backgroundColor = .systemBackground
        stack.layer.cornerRadius = 20
        return stack
    }()
    // 툴바
    var toolbar : UIToolbar = {
        let headerView = UIToolbar()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let cancelItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonTapped))
        let saveitem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonTapped))
        let label = UILabel()
        label.text = "할일추가"
        let titleItem = UIBarButtonItem(customView: label)
        var items = [UIBarButtonItem]()
        [cancelItem,flexibleSpace,titleItem,flexibleSpace,saveitem].forEach {
            items.append($0)
        }
        headerView.setItems(items, animated: false)
        return headerView
    }()
    
    // 시작일 종료일 픽업뷰 감ㅈ싸는 스택뷰
    var titleStackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.spacing = 8
        stack.backgroundColor = .systemBackground
        stack.layer.cornerRadius = 20
        return stack
    }()
    // 중요도
    let importantButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        let configuration = UIImage.SymbolConfiguration(pointSize: 30)
        button.setPreferredSymbolConfiguration(configuration, forImageIn: .normal)
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    // 할일 추가
    var titleTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "할일을 등록하세요."
        textField.backgroundColor = .systemBackground
        textField.layer.cornerRadius = 20
        return textField
    }()

    // 메모 라벨
    var discriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "메모"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    // 메모
    var discriptionTextView: UITextView = {
        let textView = UITextView()
        textView.layer.cornerRadius = 20
        textView.backgroundColor = UIColor(red: 244, green: 139, blue: 200, alpha: 1)

        textView.font = .systemFont(ofSize: 20, weight: .medium)
        return textView
    }()
    // 시작일 라벨
    var startLabel: UILabel = {
        let label = UILabel()
        label.text = "시작일"
        return label
    }()
    // 종료일 라벨
    var endLabel: UILabel = {
        let label = UILabel()
        label.text = "종료일"
        return label
    }()
    // 시작일 픽업뷰
    var startDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .automatic
        picker.datePickerMode = .date
        picker.contentMode = .scaleToFill
        picker.layer.cornerRadius = 15
        picker.locale = Locale(identifier: "ko")
        //picker.addTarget(self, action:nil for: .valueChanged)
        return picker
    }()
    // 종료일 픽업뷰
    var endDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .automatic
        picker.datePickerMode = .date
        picker.contentMode = .scaleToFill
        picker.layer.cornerRadius = 15
        picker.locale = Locale(identifier: "ko")
        //picker.addTarget(self, action: #selector(endDateTapped(_ :)), for: .valueChanged)
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    private func layout(){
        view.backgroundColor = .systemBackground
        [ toolbar,titleStackView,dateStackView,discriptionLabel,discriptionTextView].forEach {
            view.addSubview($0)
        }
        titleStackView.addArrangedSubview(importantButton)
        titleStackView.addArrangedSubview(titleTextField)
        dateStackView.addArrangedSubview(startLabel)
        dateStackView.addArrangedSubview(startDatePicker)
        dateStackView.addArrangedSubview(endLabel)
        dateStackView.addArrangedSubview(endDatePicker)
        
        toolbar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        titleStackView.snp.makeConstraints {
            $0.top.equalTo(toolbar.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(70)
        }
        dateStackView.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(70)
        }
        discriptionLabel.snp.makeConstraints {
            $0.top.equalTo(dateStackView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        discriptionTextView.snp.makeConstraints {
            $0.top.equalTo(dateStackView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // 취소버튼 이벤트
    @objc func cancelButtonTapped(){
        self.dismiss(animated: true)
    }
    
    // 저장버튼 이벤트
    @objc func saveButtonTapped(){
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let startDate = dateFormatter.string(from: startDatePicker.date)
        let endDate = dateFormatter.string(from: endDatePicker.date)
        let title = titleTextField.text ?? ""
        let description = discriptionTextView.text ?? ""
        // Todo객체 생성함
        let planDo = PlanDoManager.shared.createPlanDo(title: title, startDate: startDate, endDate: endDate, description: description,isStar: isSelected)
        viewModel.addTodo(planDo)
        self.delegate?.didSelectReigster()
        self.dismiss(animated: true)
    }
    var isSelected : Bool = false
    @objc func addButtonTapped(){
        if isSelected {
            importantButton.setImage(UIImage(systemName: "star"), for: .normal)
        }else {
            importantButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
        isSelected = !isSelected
    }
    
}
