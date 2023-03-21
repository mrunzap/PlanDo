//
//  NewPlanDoView.swift
//  PlanDo
//
//  Created by donghun on 2023/03/21.
//
import UIKit
import SnapKit
import RxSwift
import RxCocoa
class NewPlanDoView: UIViewController {
    let disposeBag = DisposeBag()
    
    var headerView = HeaderView()
    let tableView = UITableView()
    let footerView = UIView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: NewPlanDoViewModel) {
        viewModel.cellData
            .debug("mainCellData", trimOutput: true)
            .drive(self.tableView.rx.items) { tv, row, data in
                switch row {
                case 0:
                    let cell = tv.dequeueReusableCell(
                        withIdentifier: "TitleCell",
                        for: IndexPath(row: row, section: 0)
                    ) as! TitleCell
                    cell.selectionStyle = .none
                    //cell.titleInputField.placeholder = data
                    cell.bind(viewModel.titleViewModel)
                    return cell
                case 1:
                    let cell = tv.dequeueReusableCell(
                        withIdentifier: "DateCell",
                        for: IndexPath(row: row, section: 0)
                    ) as! DateCell
                    cell.selectionStyle = .none
                    //cell.titleInputField.placeholder = data
                    cell.bind(viewModel.dateViewModel)
                    return cell
                case 2:
                    let cell = tv.dequeueReusableCell(
                        withIdentifier: "DetailCell",
                        for: IndexPath(row: row, section: 0)
                    ) as! DetailCell
                    cell.selectionStyle = .none
                    //cell.titleInputField.placeholder = data
                    cell.bind(viewModel.detailViewModel)
                    return cell
                default:
                    fatalError()
                }
            }
            .disposed(by: disposeBag)
        

    }
    
    func attribute() {
        tableView.backgroundColor = .white
        tableView.register(TitleCell.self, forCellReuseIdentifier: "TitleCell")
        tableView.register(DateCell.self, forCellReuseIdentifier: "DateCell")
        tableView.register(DetailCell.self, forCellReuseIdentifier: "DetailCell")
        headerView.backgroundColor = .systemPink
        footerView.backgroundColor = .black
        tableView.separatorStyle = .none
        tableView.tableFooterView = footerView
        tableView.tableHeaderView = headerView
        tableView.rowHeight = 100
//        tableView.estimatedRowHeight = 100
    }
    
    func layout() {
        view.addSubview(tableView)

        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
