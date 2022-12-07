//
//  Table+Ext.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 23/05/22.
//

import Foundation
import UIKit

extension UITableView {
    func register(with identifire: String) {
        self.register(UINib(nibName: identifire, bundle: nil), forCellReuseIdentifier: identifire)
    }

    func reloadData(completion: @escaping () -> Void) {
        self.reloadData()
        completion()
    }

    func scrollToBottomRow() {
        DispatchQueue.main.async {
            guard self.numberOfSections > 0 else { return }

            // Make an attempt to use the bottom-most section with at least one row
            var section = max(self.numberOfSections - 1, 0)
            var row = max(self.numberOfRows(inSection: section) - 1, 0)
            var indexPath = IndexPath(row: row, section: section)

            // Ensure the index path is valid, otherwise use the section above (sections can
            // contain 0 rows which leads to an invalid index path)
            while !self.indexPathIsValid(indexPath) {
                section = max(section - 1, 0)
                row = max(self.numberOfRows(inSection: section) - 1, 0)
                indexPath = IndexPath(row: row, section: section)

                // If we're down to the last section, attempt to use the first row
                if indexPath.section == 0 {
                    indexPath = IndexPath(row: 0, section: 0)
                    break
                }
            }

            // In the case that [0, 0] is valid (perhaps no data source?), ensure we don't encounter an
            // exception here
            guard self.indexPathIsValid(indexPath) else { return }
            DispatchQueue.main.async {

                self.scrollToRow(at: indexPath, at: .bottom, animated: true)
                self.layoutIfNeeded()
            }

        }
    }

    func indexPathIsValid(_ indexPath: IndexPath) -> Bool {
        let section = indexPath.section
        let row = indexPath.row
        return section < self.numberOfSections && row < self.numberOfRows(inSection: section)
    }
    
    func updateTableContentInset(tblView : UITableView) {
       // tblView.transform = CGAffineTransform(scaleX: 1, y: -1)
        let numRows = tblView.numberOfRows(inSection: 0)
        print("NUMBER OF ROWS: \(numRows)")
        tblView.layoutIfNeeded()
        var contentInsetTop = tblView.bounds.size.height
        for i in 0..<numRows {
            let rowRect = tblView.rectForRow(at: IndexPath(item: i, section: 0))
            contentInsetTop -= rowRect.size.height
            if contentInsetTop <= 0 {
                contentInsetTop = 0
                break
            }
        }
        tblView.contentInset = UIEdgeInsets(top: contentInsetTop, left: 0, bottom: 0, right: 0)
    }
    
    func scrollToBottom(animated: Bool = true) {
        let sections = self.numberOfSections
        let rows = self.numberOfRows(inSection: sections - 1)
        if (rows > 0){
            
            self.scrollToRow(at: NSIndexPath(row: rows - 1, section: sections - 1) as IndexPath, at: .bottom, animated: true)
        }
    }
}
