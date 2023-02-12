//
//  NewPlanDoTableViewController.swift
//  PlanDo
//
//  Created by donghun on 2023/02/12.
//

import UIKit
import SnapKit
import Kingfisher
class NewPlanDoTableViewController: UIViewController {
    
    var collectionView : UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        layout.sectionInset = .zero
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return cv
    }()
    var toolbar : UIToolbar = {
        let headerView = UIToolbar()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let cancelItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonTapped))
        let saveitem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonTapped))
        var items = [UIBarButtonItem]()
        [cancelItem,flexibleSpace,saveitem].forEach {
            items.append($0)
        }
        headerView.setItems(items, animated: false)
        return headerView
    }()
    
    let viewModel = PlanDoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureContraints()
    }
    
    func configureContraints(){
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(TitleCell.self, forCellWithReuseIdentifier: "TitleCell")
        collectionView.register(DateCell.self, forCellWithReuseIdentifier: "DateCell")
        collectionView.register(DescriptionCell.self, forCellWithReuseIdentifier: "DescriptionCell")
        
        collectionView.register(PlanDoCollectionViewHeader.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader, withReuseIdentifier: "PlanDoCollectionViewHeader")
        
       // collectionView.collectionViewLayout = setCollectionViewLayOut()
        //collectionView.collectionViewLayout = UICollectionViewDelegateFlowLayout()
        [collectionView,toolbar].forEach {
            view.addSubview($0)
        }
        
        toolbar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(toolbar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// layout area
extension NewPlanDoTableViewController {
    private func setCollectionViewLayOut() -> UICollectionViewLayout{
        //UICollectionViewLayout
        return createBasicListLayout()
    }
    private func createBasicListLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalWidth(0.4))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                            heightDimension: .estimated(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let sectionHeader = createSectionHeader()
          section.boundarySupplementaryItems = [sectionHeader]
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
  }
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.05))
        

        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                        elementKind: UICollectionView.elementKindSectionHeader,
                                                                        alignment: .top)
        return sectionHeader
    }
}
extension NewPlanDoTableViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
            case 0 :
                return 1
            case 1:
                return 1
            case 2:
                return 1
            default:
                return 0
                
            }

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        switch indexPath.section {
        case 0 :
            return collectionView.dequeueReusableCell(withReuseIdentifier: "TitleCell", for: indexPath) as! TitleCell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateCell", for: indexPath) as! DateCell
            return cell
        case 2:
            return collectionView.dequeueReusableCell(withReuseIdentifier: "DescriptionCell", for: indexPath) as! DescriptionCell
        default:
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
       if kind == UICollectionView.elementKindSectionHeader {
           guard let  headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "PlanDoCollectionViewHeader", for: indexPath) as? PlanDoCollectionViewHeader else {
               fatalError("Colld Not dequeue Header")
           }

           return headerView
       } else {
           return UICollectionReusableView()
       }
   }
    
}

extension NewPlanDoTableViewController: UICollectionViewDelegate {

}

extension NewPlanDoTableViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        switch indexPath.section {
        case 0 :
            return CGSize(width: collectionView.bounds.width, height: 100)
        case 1:
            return CGSize(width: collectionView.bounds.width, height: 100)
        case 2:
            return CGSize(width: collectionView.bounds.width, height: 400)
        default:
            return  CGSize(width: 0, height: 0)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        print("section:\(section)")
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
}

// 버튼 이벤트 처리
extension NewPlanDoTableViewController {   
    // 취소버튼 이벤트
    @objc func cancelButtonTapped(){
        self.dismiss(animated: true)
    }
    
    // 저장버튼 이벤트
    @objc func saveButtonTapped(){
//        guard let startDate = startButton.currentTitle,
//              let endDate  = endButton.currentTitle else { return }
//        let title = titleTextField.text ?? "제목없음"
//        let description = discriptionTextField.text ?? ""
//         //Todo객체 생성함
//        let planDo = PlanDoManager.shared.createPlaDo(title, startDate: startDate, endDate: endDate, description: description)
//        viewModel.addTodo(planDo)
    }
}
