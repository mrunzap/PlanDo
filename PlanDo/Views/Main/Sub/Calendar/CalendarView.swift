//
//  CalendarView.swift
//  PlanDo
//
//  Created by donghun on 2023/02/25.
//

import UIKit
import FSCalendar
import RxSwift
import RxCocoa
import RxGesture

class CalendarView: FSCalendar{
    
    let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
    }
    
    func bind(_ viewModel: CalendarViewModel){
        self.rx.swipeGesture([.up,.down])
            .when(.recognized)
            .bind(to: viewModel.occurCalenderGesture)
            .disposed(by: disposeBag)
        
        viewModel.occurCalenderGesture
            .asSignal()
            .emit(to: self.rx.changeCalenderMode)
            .disposed(by: disposeBag)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func attribute(){
        self.locale = Locale(identifier: "ko_KR")
        self.scrollEnabled = true
        self.scrollDirection = .horizontal
        self.appearance.headerDateFormat = "YYYY. M"
        self.appearance.headerTitleColor = .label
        self.appearance.headerTitleAlignment = .center
        self.headerHeight = 40.0
        self.rowHeight = 500
        self.scope = .week
    }
    
    
    private func bind(){
 
    }

    
}
extension Reactive where Base: CalendarView {
    var changeCalenderMode: Binder<UISwipeGestureRecognizer> {
        return Binder(base) { base, data in
            if data.direction == .up {
                base.scope = .week
            } else {
                base.scope = .month
            }
        }
    }
}
