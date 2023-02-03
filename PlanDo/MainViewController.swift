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


class MainViewController: UIViewController {
    
    var calendarHeightConstraint = NSLayoutConstraint()
    var headerSize:CGFloat?
    let buttonView : UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        return view
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        let configuration = UIImage.SymbolConfiguration(pointSize: 1000)
        button.setPreferredSymbolConfiguration(configuration, forImageIn: .normal)
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let searchBar = UISearchBar()
    var collectionView : UICollectionView = {
            var layout = UICollectionViewFlowLayout()
            layout.minimumLineSpacing = 0
            layout.scrollDirection = .vertical
            layout.sectionInset = .zero
            
            let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
            return cv
        }()
    private let calendar: FSCalendar = {
        let calendar = FSCalendar(frame: .zero)
        
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.scrollEnabled = true
        calendar.scrollDirection = .horizontal
        calendar.appearance.headerDateFormat = "YYYY. M"
        calendar.appearance.headerTitleColor = .label
        calendar.appearance.headerTitleAlignment = .center
        calendar.headerHeight = 40.0
        calendar.scope = .week
        return calendar
    }()
    
    @objc func addButtonTapped(){
        let viewController = NewPlanDoViewController()
        //viewController.modalPresentationStyle = .currentContext
        //viewController.preferredContentSize = CGSize(width: 400, height: 400)
        present(viewController, animated: false)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = searchBar
        view.backgroundColor = .systemBackground
        calendar.delegate = self

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PlanDoCollectionViewCell.self, forCellWithReuseIdentifier: "PlanDoCollectionViewCell")
        collectionView.register(PlanDoCollectionViewHeader.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader, withReuseIdentifier: "PlanDoCollectionViewHeader")
        collectionView.collectionViewLayout = setCollectionViewLayOut()
        view.addSubview(calendar)
        view.addSubview(collectionView)
        calendar.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(400)
        }
      
        collectionView.snp.makeConstraints {
            $0.top.equalTo(calendar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        view.addSubview(button)
       
        button.snp.makeConstraints {
            $0.height.width.equalTo(70)
            $0.bottom.equalToSuperview().inset(30)
            $0.trailing.equalToSuperview().inset(70)
        }

        calendar.rx.swipeGesture([.up,.down])
            .when(.recognized)
            .bind { _ in
                if self.calendar.scope == .month {
                    self.calendar.setScope(.week, animated: false)
                } else {
                    self.calendar.setScope(.month, animated: false)
                }
            }
        
    }
}

// datasource
extension MainViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlanDoCollectionViewCell", for: indexPath) as? PlanDoCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
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

// delegate
extension MainViewController {
    
}

// layout Object Handle
extension MainViewController {
    private func setCollectionViewLayOut() -> UICollectionViewLayout{
        //UICollectionViewLayout
        return createBasicListLayout()
    }
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.05))
        

        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                        elementKind: UICollectionView.elementKindSectionHeader,
                                                                        alignment: .top)
        return sectionHeader
    }
    private func createBasicListLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
      
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(44))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])
      
        let section = NSCollectionLayoutSection(group: group)
        let sectionHeader = createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}

extension MainViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let itemSpacing : CGFloat = 10

            let myWidth : CGFloat = (collectionView.bounds.width - itemSpacing * 2) / 3


            return CGSize(width: myWidth, height: myWidth)
        }
}

extension MainViewController: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        print(bounds.height)
        calendar.snp.updateConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(bounds.height)
        }
    }
}
