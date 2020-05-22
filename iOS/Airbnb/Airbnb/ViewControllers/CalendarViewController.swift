//
//  CalendarViewController.swift
//  Airbnb
//
//  Created by jinie on 2020/05/20.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {
    @IBOutlet weak var calendarCollectionView: UICollectionView!
    
    private var dateManager = DateManager()
    private var chooseDays: [IndexPath] = []
    
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
        let weekday = dateManager.firstWeekday(month: indexPath.section)
        let thisMonth = dateManager.month(index: indexPath.section)
        let date = indexPath.item - weekday + 1
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCollectionViewCell
        if chooseDays.contains(indexPath) { cell.select() }
        if 1...dateManager.countOfDays(year: 2020, month: thisMonth) ~= date {
            cell.configure(date: date)
        }
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dateManager.countOfMonths().count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CalendarHeader", for: indexPath) as! CalendarHeaderView
        headerView.set("2020년 \(dateManager.month(index: indexPath.section))월")
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
        if cell.isSelected {
            if chooseDays.count < 2 {
                collectionView.deselectItem(at: indexPath, animated: true)
                chooseDays.remove(at: chooseDays.firstIndex(of: indexPath)!)
                cell.deselect()
            }else if chooseDays.contains(indexPath) {
                removeAndReload(collectionView, cell: cell, indexPath: indexPath)
            }
        }else {
            if chooseDays.count == 0 {
                mark(collectionView, cell: cell, indexPath: indexPath)
            }else {
                if compare(indexPath) {
                    removeAndReload(collectionView, cell: cell, indexPath: indexPath)
                }else if !compare(indexPath), chooseDays.count < 2 {
                    mark(collectionView, cell: cell, indexPath: indexPath)
                }else {
                    removeAndReload(collectionView, cell: cell, indexPath: indexPath)
                }
            }
        }
        return false
    }
    
    private func mark(_ collectionView: UICollectionView, cell: CalendarCollectionViewCell, indexPath: IndexPath) {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        cell.select()
        chooseDays.append(indexPath)
    }
    
    private func removeAndReload(_ collectionView: UICollectionView, cell: CalendarCollectionViewCell, indexPath: IndexPath) {
        chooseDays.removeAll()
        mark(collectionView, cell: cell, indexPath: indexPath)
        collectionView.reloadData()
    }
    
    private func compare(_ last: IndexPath) -> Bool {
        guard let first = chooseDays.first else { return false }
        return first > last
    }
}
