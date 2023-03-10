import RxCocoa
import RxSwift













//Observable<Observable<String>>
protocol 선수 {
    var 점수: BehaviorSubject<Int>{get}
}

struct 양궁선수: 선수 {
    var 점수: BehaviorSubject<Int>
    
    
}

let 한국국가대표 = 양궁선수(점수: BehaviorSubject<Int>(value: 10))
let 미국국가대표 = 양궁선수(점수: BehaviorSubject<Int>(value: 8))
