//
//  PlanDoManager.swift
//  PlanDo
//
//  Created by donghun on 2023/02/12.
//

import UIKit

// 
class PlanDoManager {
    var planDos: [PlanDo] = []
    static let shared = PlanDoManager()
    static var lastId: Int = 0
    private init(){}
    // PlanDo객체 반환하는 함수(view에서는 PlanDo 인스턴스를 알 필요가 없다)
    func createPlanDo(title: String, startDate: String, endDate: String, description: String, isStar: Bool) -> PlanDo{
        let nextId = PlanDoManager.lastId + 1
        PlanDoManager.lastId = nextId
        return PlanDo(id: nextId, title: title, startDate: startDate, endDate: endDate, description: description,isStar: isStar,isDone: false)
    }
    
    func addTodo(_ planDo: PlanDo){
        planDos.append(planDo)
        print(planDos.count)
        Storage.store(planDos, to: .documents, as: "planDo.json")
    }
    func retrieveTodo() {
//        planDos = Storage.retrive("planDo.json", from: .documents, as: [PlanDo].self) ?? []
//
//        let lastId = planDos.last?.id ?? 0
//        PlanDoManager.lastId = lastId
    }
}
