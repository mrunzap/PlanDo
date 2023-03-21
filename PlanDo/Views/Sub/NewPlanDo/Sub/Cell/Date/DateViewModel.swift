//
//  DateViewModel.swift
//  PlanDo
//
//  Created by donghun on 2023/03/21.
//

import UIKit
import RxCocoa
import RxSwift

struct DateCellViewModel {
    let startDateButtonTapped = PublishRelay<Date>()
    let endDateButtonTapped = PublishRelay<Date>()
}
