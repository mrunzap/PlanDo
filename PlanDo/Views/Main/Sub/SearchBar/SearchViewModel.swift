//
//  SearchViewModel.swift
//  PlanDo
//
//  Created by donghun on 2023/02/25.
//

import UIKit
import RxCocoa
import RxSwift

struct SearchBarViewModel {
    let queryText = PublishRelay<String?>()
    let searchButtonTapped = PublishRelay<Void>()
    let shouldLoadResult: Observable<String>
    init(){
        
        self.shouldLoadResult = searchButtonTapped
         .withLatestFrom(queryText) { $1 ?? ""}
         .filter { !$0.isEmpty }
         .distinctUntilChanged()
        
        
    }
}
