//
//  CalendarViewController.swift
//  Airbnb
//
//  Created by jinie on 2020/05/20.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit

final class CalendarViewController: UIViewController {
    @IBOutlet weak var calendarCollectionView: UICollectionView!
    
    private var dateManager = DateManager()
    private var chooseDays: [IndexPath] = []
    private var periodDays: [IndexPath] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        calendarCollectionView.dataSource = self
        calendarCollectionView.delegate = self
    }
}

extension CalendarViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 42
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let firstWeekday = dateManager.firstWeekday(thisMonth: indexPath.section)
        let date = indexPath.item - firstWeekday + 1
        let thisMonth = dateManager.thisMonth(indexPath.section)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCollectionViewCell
        if 1...dateManager.countOfDays(year: 2020, month: thisMonth) ~= date { cell.configure(date: date) }
        if chooseDays.contains(indexPath) { cell.select() }
        changeWholePeriodCellsBackground(collectionView, cell: cell, indexPath: indexPath)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dateManager.monthsFromNowToDecember().count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CalendarHeader", for: indexPath) as! CalendarHeaderView
        let yearMonth = dateManager.yearMonth(indexPath.section)
        headerView.set("\(yearMonth.year)년 \(yearMonth.month)월")
        return headerView
    }
}

extension CalendarViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.bounds.width / 7
        return CGSize(width: width, height: width)
    }
}

extension CalendarViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let cell = collectionView.cellForItem(at: indexPath) as! CalendarCollectionViewCell
        judgeCellSelected(cell, collectionView: collectionView, indexPath: indexPath)
        changeWholePeriodCellsBackground(collectionView, cell: cell, indexPath: indexPath)
        return false
    }
    
    private func judgeCellSelected(_ cell: CalendarCollectionViewCell, collectionView: UICollectionView, indexPath: IndexPath) {
        if cell.isSelected {
            selectAlreadySelected(cell, collectionView: collectionView, indexPath: indexPath)
        }else {
            selectAlreadyDeselected(cell, collectionView: collectionView, indexPath: indexPath)
        }
    }
    
    private func selectAlreadySelected(_ cell: CalendarCollectionViewCell, collectionView: UICollectionView, indexPath: IndexPath) {
        if chooseDays.count < 2 {
            deselect(cell, collectionView: collectionView, indexPath: indexPath)
        }else {
            updateSelectedCell(cell, collectionView: collectionView, indexPath: indexPath)
        }
    }
    
    private func selectAlreadyDeselected(_ cell: CalendarCollectionViewCell, collectionView: UICollectionView, indexPath: IndexPath) {
        if chooseDays.count == 0 {
            mark(cell, collectionView: collectionView, indexPath: indexPath)
        }else if chooseDays.count == 1 {
            judgeIsSecond(cell, collectionView: collectionView, indexPath: indexPath)
        } else {
            updateSelectedCell(cell, collectionView: collectionView, indexPath: indexPath)
        }
    }
    
    private func judgeIsSecond(_ cell: CalendarCollectionViewCell, collectionView: UICollectionView, indexPath: IndexPath) {
        if IsFirstBigger(indexPath) {
            updateSelectedCell(cell, collectionView: collectionView, indexPath: indexPath)
        }else if !chooseDays.contains(indexPath) {
            mark(cell, collectionView: collectionView, indexPath: indexPath)
            checkPeriod(collectionView: collectionView, bigger: indexPath, smaller: chooseDays.first)
        }else {
            deselect(cell, collectionView: collectionView, indexPath: indexPath)
        }
    }
    
    private func deselect(_ cell: CalendarCollectionViewCell, collectionView: UICollectionView, indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        cell.deselect()
        remove(indexPath)
    }
    
    private func remove(_ indexPath: IndexPath) {
        chooseDays.remove(at: chooseDays.firstIndex(of: indexPath)!)
    }
    
    private func mark(_ cell: CalendarCollectionViewCell, collectionView: UICollectionView, indexPath: IndexPath) {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        cell.select()
        chooseDays.append(indexPath)
    }
    
    private func updateSelectedCell(_ cell: CalendarCollectionViewCell, collectionView: UICollectionView, indexPath: IndexPath) {
        if chooseDays.count == 2 {
            let cells = configureCheckInOut(cell, collectionView: collectionView, indexPath: indexPath)
            cells?.checkInCell.hideRightBackground()
            cells?.checkOutCell.hideLeftBackground()
        }
        removeAll()
        reload(collectionView, indexPath: indexPath, cell: cell)
    }
    
    private func configureCheckInOut(_ cell: CalendarCollectionViewCell, collectionView: UICollectionView, indexPath: IndexPath) -> (checkInCell: CalendarCollectionViewCell, checkOutCell: CalendarCollectionViewCell)? {
        guard let checkInCell = configurePeriodDay(collectionView, indexPath: periodDays.first) else { return nil }
        guard let checkOutCell = configurePeriodDay(collectionView, indexPath: periodDays.last) else { return nil }
        return (checkInCell, checkOutCell)
    }
    
    private func configurePeriodDay(_ collectionView: UICollectionView, indexPath: IndexPath?) -> CalendarCollectionViewCell? {
        guard let checkedCellIndexPath = indexPath else { return nil }
        guard let checkedCell = collectionView.cellForItem(at: checkedCellIndexPath) as? CalendarCollectionViewCell else { return nil}
        return checkedCell
    }
    
    private func removeAll() {
        chooseDays.removeAll()
        periodDays.removeAll()
    }
    
    private func reload(_ collectionView: UICollectionView, indexPath: IndexPath, cell: CalendarCollectionViewCell) {
        mark(cell, collectionView: collectionView, indexPath: indexPath)
        collectionView.reloadData()
    }
    
    private func IsFirstBigger(_ last: IndexPath) -> Bool {
        guard let first = chooseDays.first else { return false }
        return first > last
    }
    
    private func checkPeriod(collectionView: UICollectionView, bigger: IndexPath?, smaller: IndexPath?) {
        guard let smaller = smaller, let bigger = bigger else { return }
        if bigger.section == smaller.section {
            checkPeriodSameSection(collectionView: collectionView, bigger: bigger, smaller: smaller)
        }else {
            checkPeriodDifferentSection(collectionView: collectionView, bigger: bigger, smaller: smaller)
        }
    }
    
    private func checkPeriodSameSection (collectionView: UICollectionView, bigger: IndexPath, smaller: IndexPath) {
        for item in smaller.item...bigger.item {
            let indexPath = IndexPath(item: item, section: smaller.section)
            periodDays.append(indexPath)
        }
    }
    
    private func checkPeriodDifferentSection(collectionView: UICollectionView, bigger: IndexPath, smaller: IndexPath) {
        let lastItem = collectionView.numberOfItems(inSection: smaller.section) - 1
        for item in smaller.item...lastItem {
            let indexPath = IndexPath(item: item, section: smaller.section)
            periodDays.append(indexPath)
        }
        for item in 0...bigger.item {
            let indexPath = IndexPath(item: item, section: bigger.section)
            periodDays.append(indexPath)
        }
    }
    
    private func changeWholePeriodCellsBackground(_ collectionView: UICollectionView, cell: CalendarCollectionViewCell, indexPath: IndexPath) {
        if chooseDays.count == 2 {
            let cells = configureCheckInOut(cell, collectionView: collectionView, indexPath: indexPath)
            cells?.checkInCell.configureRightBackground()
            cells?.checkOutCell.configureLeftBackground()
        }
        
        if periodDays.count > 2 {
            for index in 1..<periodDays.count - 1 {
                changeBackgroundPeriodCells(collectionView, indexPath: periodDays[index])
            }
        }
    }
    
    private func changeBackgroundPeriodCells(_ collectionView: UICollectionView, indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CalendarCollectionViewCell
        cell.changeBackground()
    }
}
