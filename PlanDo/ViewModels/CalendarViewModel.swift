//
//  CalendarViewModel.swift
//  PlanDo
//
//  Created by donghun on 2023/02/25.
//

import UIKit
import RxCocoa
import RxSwift

struct CalendarViewModel {
    let occurCalenderGesture = PublishRelay<UISwipeGestureRecognizer>()
}
