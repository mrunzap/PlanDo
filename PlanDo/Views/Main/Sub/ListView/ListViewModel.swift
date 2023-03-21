//
//  ListViewModel.swift
//  PlanDo
//
//  Created by donghun on 2023/02/25.
//

import UIKit
import RxCocoa
import RxSwift

struct ListViewModel {
    let cellData = PublishSubject<[PlanDo]>()
    let cellDataDriver: Driver<[PlanDo]>
  
    init(){
       
        self.cellDataDriver = cellData
            .asDriver(onErrorJustReturn: [])
        print("cellData::::\(cellDataDriver)")
    }
}
