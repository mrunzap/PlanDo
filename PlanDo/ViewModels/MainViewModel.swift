//
//  MainViewModel.swift
//  PlanDo
//
//  Created by donghun on 2023/02/25.
//

import UIKit
import RxCocoa
import RxSwift

struct MainViewModel {
    
    let disposeBag = DisposeBag()
    let listViewModel = ListViewModel()
    let searchBarViewModel = SearchBarViewModel()
    let calendarViewModel = CalendarViewModel()
    let viewDidLoadEvent = PublishRelay<Void>()
    
    // successData 옵저버블 등록 - 필터링 위함
    var successData: Observable<[PlanDo]>
    var successFilterData: Observable<[PlanDo]>
    init(model: MainModel = MainModel()){
        
        
        let result = Observable
            .merge(
                viewDidLoadEvent.asObservable(),
                searchBarViewModel.searchButtonTapped.asObservable()
            )
            .flatMap(model.searchPlanDo)
            .asObservable()
            .share()
        
        
        successData = result
            .compactMap { data -> [PlanDo] in   // Result<[PlanDo],FetchNetworkError>
                guard case .success(let value) = data else {
                    return []
                }

                return value
            }
        
        successFilterData = searchBarViewModel.shouldLoadResult
            .filter{ $0 != ""}
            .debug("mainViewModel QueryText")
            .withLatestFrom(successData){ query, observer in
                observer.filter { $0.title.contains(query) }
            }
            
        
        let errorData = result
            .debug()
            .compactMap { data -> String? in   // Result<[PlanDo],FetchNetworkError>
                guard case .failure(let error) = data else {
                    return nil
                }
                return error.localizedDescription
            }
        print("successData::::\(successData)")
        Observable.merge(
            successData,
            successFilterData
        )
            .debug("successData")
            .bind(to: listViewModel.cellData)
            .disposed(by: disposeBag)
        

        
    }
    

}

