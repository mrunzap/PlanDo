//
//  ListView.swift
//  PlanDo
//
//  Created by donghun on 2023/02/25.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
class ListView: UITableView {
    let disposeBag = DisposeBag()
    
    let headerView = PlanDoTableViewHeader(frame: CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: 50)))
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        attribute()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func bind(_ viewModel: ListViewModel){
        viewModel.cellData
            .asDriver(onErrorDriveWith: .empty())
            .debug("cellDataDrirver")
            .drive(self.rx.items){ tv, row, data in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = tv.dequeueReusableCell(withIdentifier: "PlanDoTableViewCell", for: indexPath ) as! PlanDoTableViewCell
                cell.setData(planDo: data)
                return cell
            }
           
            .disposed(by: disposeBag)
        
    }
    private func attribute(){
        self.register(PlanDoTableViewCell.self, forCellReuseIdentifier:"PlanDoTableViewCell")
        self.tableHeaderView = headerView
        
        self.backgroundColor = .white
        self.rowHeight = 100
        self.separatorStyle = .singleLine
        
        
    }
}
