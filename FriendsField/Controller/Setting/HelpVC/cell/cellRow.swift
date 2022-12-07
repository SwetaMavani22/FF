//
//  cellRow.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 21/05/22.
//

import Foundation
import UIKit
import ExpyTableView

class cellRow : UITableViewCell {
    
    @IBOutlet var lblDesc : UILabel!
    @IBOutlet var viewLine : UIView!

    func changeState(_ state: ExpyState, cellReuseStatus cellReuse: Bool) {
        
        switch state {
        case .willExpand:
            print("WILL EXPAND")
            hideSeparator()
            self.viewLine.isHidden = true
            
        case .willCollapse:
            print("WILL COLLAPSE")
            self.viewLine.isHidden = false

        case .didExpand:
            print("DID EXPAND")
            
        case .didCollapse:
            showSeparator()
            print("DID COLLAPSE")
        }
    }
}
