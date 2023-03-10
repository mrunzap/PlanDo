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
    
//    func getBlogListCellData(_ value: DKBlog?) -> [BlogListCellData] {
//        guard let value = value else {
//            return []
//        }
//        
//        return value.documents
//            .map {
//                let thumbnailURL = URL(string: $0.thumbnail ?? "")
//                return BlogListCellData(
//                    thumbnailURL: thumbnailURL,
//                    name: $0.name,
//                    title: $0.title,
//                    datetime: $0.datetime
//                )
//            }
//    }
}
