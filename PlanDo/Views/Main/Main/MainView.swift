//
//  MainViewController.swift
//  PlanDo
//
//  Created by donghun on 2023/01/27.
//

import UIKit
import FSCalendar
import SnapKit
import RxViewController
import RxSwift
import Floaty

class MainView: UIViewController{
    let addButton = AddButton()
    let searchBar = SearchBar()
    let tableView = ListView()
    let calendar = CalendarView()
    let disposeBag = DisposeBag()
    let newPlaDoView = NewPlanDoView()
    let floaty = Floaty()
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print("init")
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func bind(_ viewModel: MainViewModel){
        self.rx.viewWillAppear
            .map { bool in Void()}
            .bind(to: viewModel.viewDidLoadEvent)
            .disposed(by: disposeBag)

        calendar.bind(viewModel.calendarViewModel)
        tableView.bind(viewModel.listViewModel)
        searchBar.bind(viewModel.searchBarViewModel)
        newPlaDoView.bind(viewModel.newPlaDoViewModel)
       
    }
    func attribute(){
        view.backgroundColor = .systemBackground
        calendar.delegate = self
        calendar.dataSource = self
        floaty.sticky = true
        floaty.handleFirstItemDirectly = true
        floaty.addItem(title: "") { _ in
            self.presentNewPlanDo()
        }
    }
    
    func presentNewPlanDo(){
        
        self.present(newPlaDoView , animated: true)
    }
    func layout(){
        view.addSubview(searchBar)
        view.addSubview(calendar)
        view.addSubview(tableView)
        view.addSubview(addButton)
        
        view.addSubview(floaty)
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

        floaty.snp.makeConstraints {
            $0.height.width.equalTo(70)
            $0.bottom.equalToSuperview().inset(30)
            $0.trailing.equalToSuperview().inset(70)
        }
    }
}


// FSCalendar week or month 에 따른 view 사이즈 조절
extension MainView: FSCalendarDelegate,FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.snp.updateConstraints{make in
            make.top.equalTo(self.searchBar.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(bounds.height)
        }
    }
}
