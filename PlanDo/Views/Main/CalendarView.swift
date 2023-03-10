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
    // week, month 전달. calenderView -> Mainview
    // MainView에서는 그값에 따라 크기 변경
    let occurCalenderGesture = PublishRelay<UISwipeGestureRecognizer>()
    //let directionGesture: Observable<String>
    override init(frame: CGRect) {
        super.init(frame: frame)
        bind()
        attribute()
        
        self.rx.swipeGesture([.up,.down])
            .when(.recognized)
            .bind(to: occurCalenderGesture)
            .disposed(by: disposeBag)
        
//        occurCalenderGesture
//            .asSignal()
//            .emit(to: self.rx.changeCalenderMode)
//            .disposed(by: disposeBag)
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
//        self.weekdayHeight = 30
        self.rowHeight = 500
        self.scope = .week
        self.backgroundColor = .systemPink
    }
    
    
    private func bind(){
 
    }

    
}
extension CalendarView : FSCalendarDelegate {
    
}
extension Reactive where Base: CalendarView {
    var changeCalenderMode: Binder<UISwipeGestureRecognizer> {
        return Binder(base) { base, data in
            if data.direction == .down {
                base.scope = .month
            } else if data.direction == .up {
                base.scope = .week
            }
        }
    }
}
//
