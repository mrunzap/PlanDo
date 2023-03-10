//
//  PlanDo.swift
//  PlanDo
//
//  Created by donghun on 2023/02/12.
//

import UIKit

// 참조타입이 아닌 복사 기능하기에 Struct 채택
struct PlanDo: Codable {
    let id: Int
    var title: String
    var startDate: String
    var endDate: String
    var description: String
    var isStar: Bool
    var isDone: Bool
    static func == (lhs: Self, rhs: Self) -> Bool {
        // [x]TODO: 동등 조건 추가
        return lhs.id == rhs.id
    }
}
