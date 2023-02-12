//
//  PlanDoManager.swift
//  PlanDo
//
//  Created by donghun on 2023/02/12.
//

import UIKit

// 
class PlanDoManager {
    
    static let shared = PlanDoManager()
    static var lastId: Int = 0
    private init(){}
    // PlanDo객체 반환하는 함수(view에서는 PlanDo 인스턴스를 알 필요가 없다)
    func createPlaDo(_ title: String, startDate: String, endDate: String, description: String) -> PlanDo{
        let nextId = PlanDoManager.lastId + 1
        PlanDoManager.lastId = nextId
        return PlanDo(id: nextId, title: title, startDate: startDate, endDate: endDate, description: description)
    }
    
    func addTodo(_ planDo: PlanDo){
        Storage.store(planDo, to: .documents, as: "planDo.json")
    }
}
