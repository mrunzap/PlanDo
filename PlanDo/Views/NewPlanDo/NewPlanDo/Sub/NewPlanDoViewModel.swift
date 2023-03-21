//
//  NewPlanDoHeadViewModel.swift
//  PlanDo
//
//  Created by donghun on 2023/03/21.
//
import UIKit
import RxCocoa
import RxSwift

struct NewPlanDoViewModel {
    
    let titleViewModel = TitleCellViewModel()
    let dateViewModel = DateCellViewModel()
    let detailViewModel = DetailViewModel()
    
    let cellData: Driver<[String]>
    
    init(){
        
        let title = Observable.just("할일을 입력해주세요")
        let date = Observable.just("할일을 입력해주세요")
        let detail = Observable.just("메모")
        self.cellData = Observable
            .combineLatest(
                title,
                date,
                detail
            ){
                [$0,$1,$2]
            }
            .asDriver(onErrorDriveWith: .empty())
    }
}
