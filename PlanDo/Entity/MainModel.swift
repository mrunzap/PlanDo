//
//  MainModel.swift
//  PlanDo
//
//  Created by donghun on 2023/02/28.
//

import RxSwift
import RxCocoa

struct MainModel {
    
    func searchPlanDo() -> Single<Result<[PlanDo],FetchNetworkError>> {
        return Storage.retrive("planDo.json", from: .documents, as: [PlanDo].self)
    }
    
    func getDoValue(_ result: Result<[PlanDo], FetchNetworkError>) -> [PlanDo]? {
        guard case .success(let value) = result else {
            return nil
        }
        print(value)
        return value
    }

}
