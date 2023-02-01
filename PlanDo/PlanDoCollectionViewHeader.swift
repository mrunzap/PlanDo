//
//  PlanDoCollectionViewHeader.swift
//  PlanDo
//
//  Created by donghun on 2023/01/30.
//

import UIKit
import FSCalendar
import SnapKit

class PlanDoCollectionViewHeader: UICollectionReusableView {
    private let calendar: FSCalendar = {
        let calendar = FSCalendar(frame: .zero)
        
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.backgroundColor = .systemBackground
        calendar.scrollEnabled = true
        calendar.scrollDirection = .horizontal
        
        calendar.appearance.headerDateFormat = "YYYY. M"
        calendar.appearance.headerTitleColor = .label
        calendar.appearance.headerTitleAlignment = .center
        calendar.headerHeight = 40.0
        
        return calendar
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        calendar.delegate = self
        calendar.dataSource = self
        
        addSubview(calendar)
        
        calendar.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview().inset(12)
        }
    }
    override func addGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer) {
        print("wptmxj")
    }
    
}

extension PlanDoCollectionViewHeader : FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("선택한 날짜는요~\(date)")
    }
    func collectionView(_ collectionView: UICollectionView, shouldBeginMultipleSelectionInteractionAt indexPath: IndexPath) -> Bool {
        // Returning `true` automatically sets `collectionView.isEditing`
        // to `true`. The app sets it to `false` after the user taps the Done button.
        print("\(#function)1111")
        return true
    }

    func collectionView(_ collectionView: UICollectionView, didBeginMultipleSelectionInteractionAt indexPath: IndexPath) {
        // Replace the Select button with Done, and put the
        // collection view into editing mode.
        print("\(#function)ㅇㅇㅇㅇ")
    }

    func collectionViewDidEndMultipleSelectionInteraction(_ collectionView: UICollectionView) {
        print("\(#function)")
    }
}

extension PlanDoCollectionViewHeader : FSCalendarDataSource{
    
}

