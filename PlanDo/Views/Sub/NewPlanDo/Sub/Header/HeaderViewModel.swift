//
//  HeaderViewModel.swift
//  PlanDo
//
//  Created by donghun on 2023/03/21.
//

import UIKit
import RxCocoa
import RxSwift

struct HeaderViewModel {
    let cancelButtonTapped = PublishRelay<Void>()
    let saveButtonTapped = PublishRelay<Void>()
}
