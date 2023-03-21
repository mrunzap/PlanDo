//
//  NewPlanDoHeaderView.swift
//  PlanDo
//
//  Created by donghun on 2023/03/21.
//

import UIKit
import RxCocoa
import RxSwift
class HeaderView: UIToolbar {
    
    let disposeBag = DisposeBag()
    let cancelItem = UIBarButtonItem(title: "취소", menu: nil)
    let saveitem   = UIBarButtonItem(title: "저장", menu: nil)
    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
    override init(frame: CGRect) {
        super.init(frame: CGRect(origin: .zero,
                                 size: CGSize(width: UIScreen.main.bounds.width,
                                              height: 50)))
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: HeaderViewModel){
        self.cancelItem.rx.tap
            .bind(to: viewModel.cancelButtonTapped)
            .disposed(by: disposeBag)
        
        self.saveitem.rx.tap
            .bind(to: viewModel.saveButtonTapped)
            .disposed(by: disposeBag)
    }
    
    private func attribute(){
        let label = UILabel()
        label.text = "할일추가"
        let titleItem = UIBarButtonItem(customView: label)
        
        var items = [UIBarButtonItem]()
        [cancelItem,flexibleSpace,titleItem,flexibleSpace,saveitem].forEach {
            items.append($0)
        }
        self.setItems(items, animated: false)
    }
}
