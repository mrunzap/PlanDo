//
//  MainViewController.swift
//  PlanDo
//
//  Created by donghun on 2023/01/27.
//

import UIKit
import SnapKit

class MainViewController: UICollectionViewController {
    
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
        return button
    }()
    let searchBar = UISearchBar()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = searchBar
        view.backgroundColor = .systemBackground
        
        collectionView.register(PlanDoCollectionViewCell.self, forCellWithReuseIdentifier: "PlanDoCollectionViewCell")
        collectionView.register(PlanDoCollectionViewHeader.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader, withReuseIdentifier: "PlanDoCollectionViewHeader")
        collectionView.collectionViewLayout = setCollectionViewLayOut()
        
        view.addSubview(button)
        
        button.snp.makeConstraints {
            $0.height.width.equalTo(70)
            $0.bottom.equalToSuperview().inset(30)
            $0.trailing.equalToSuperview().inset(70)
        }
    }
}

// datasource
extension MainViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlanDoCollectionViewCell", for: indexPath) as? PlanDoCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
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

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))

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
