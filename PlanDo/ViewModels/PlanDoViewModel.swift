//
//  PlanDoViewModel.swift
//  PlanDo
//
//  Created by donghun on 2023/02/12.
//

import UIKit

class PlanDoViewModel {
    
    // PlanDo 모델 참조
    var planDo: PlanDo?

    // PlanDoManager객체 참조(싱글톤)
    private let manager = PlanDoManager.shared
    func addTodo(_ planDo: PlanDo){
        manager.addTodo(planDo)
    }
    
    func loadTasks() {
        manager.retrieveTodo()
    }
    var planDos: [PlanDo] {
        return manager.planDos
    }

}
