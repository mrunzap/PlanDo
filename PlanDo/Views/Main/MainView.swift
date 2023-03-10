//
//  MainViewController.swift
//  PlanDo
//
//  Created by donghun on 2023/01/27.
//

import UIKit
import FSCalendar
import SnapKit
import RxGesture
import RxCocoa
import RxSwift


class MainView: UIViewController{
    let disposeBag = DisposeBag()
    let addButton = AddButton()
    let searchBar = SearchBar()
    let tableView = ListView()
    let calendar = CalendarView()

    let model = MainModel()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
      
        print("Main")
        bind()
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: MainViewModel){
        
        print("MainViewModel Bind!")
        //tableView.binding(viewModel.listViewModel)
        
    }
    
    func bind(){
        print("Main Bind")
        let result = model.searchPlanDo()
            .asObservable()
            .debug()
            .share()
        
        let successData = result
            .debug()
            .compactMap { data -> [PlanDo] in   // Result<[PlanDo],FetchNetworkError>
                guard case .success(let value) = data else {
                    return []
                }
                return value
            }

        let errorData = result
            .debug()
            .compactMap { data -> String? in   // Result<[PlanDo],FetchNetworkError>
                guard case .failure(let error) = data else {
                    return nil
                }
                return error.localizedDescription
            }

        successData
            .bind(to: tableView.cellData)
            .disposed(by: disposeBag)
        
        
        calendar.occurCalenderGesture
            .asSignal()
            .emit(to: self.rx.changeCalenderMode)
            .disposed(by: disposeBag)
    }
    func attribute(){
        view.backgroundColor = .systemBackground
        calendar.delegate = self
        calendar.dataSource = self
        // 월~일 글자 폰트 및 사이즈 지정
        self.calendar.appearance.weekdayFont = .systemFont(ofSize: 20)
         // 숫자들 글자 폰트 및 사이즈 지정
         self.calendar.appearance.titleFont = .systemFont(ofSize: 20)

    }
    
    func layout(){
        view.addSubview(searchBar)
        view.addSubview(calendar)
        view.addSubview(tableView)
        view.addSubview(addButton)
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        calendar.snp.makeConstraints{
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(calendar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        addButton.snp.makeConstraints {
            $0.height.width.equalTo(70)
            $0.bottom.equalToSuperview().inset(30)
            $0.trailing.equalToSuperview().inset(70)
        }
    }
}
extension Reactive where Base: MainView {
    var changeCalenderMode: Binder<UISwipeGestureRecognizer> {
        return Binder(base) { base, data in
            print(data)
            if data.direction == .up {
                base.calendar.scope = .week
            } else {
                base.calendar.scope = .month
            }
        }
    }
}


extension MainView: FSCalendarDelegate,FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        print("ddddddd\(bounds.height)")
        calendar.snp.updateConstraints{make in
            make.top.equalTo(self.searchBar.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(bounds.height)
        }
    }
}
