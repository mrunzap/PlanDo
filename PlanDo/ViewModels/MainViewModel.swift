//
//  MainViewModel.swift
//  PlanDo
//
//  Created by donghun on 2023/02/25.
//

import UIKit
import RxCocoa
import RxSwift

class MainViewModel {
    
    let disposeBag = DisposeBag()
    let listViewModel = ListViewModel()
    let searchBarViewModel = SearchBarViewModel()
    
    
    init(model: MainModel = MainModel()){
        //let cellData = model.searchPlanDo()
        // 1. searchBar Enter했을 때 이벤트
        // 2. 검색버튼 클릭했을 때,
        // 3. init일 때, 불러옴.

      
    }
    

}

