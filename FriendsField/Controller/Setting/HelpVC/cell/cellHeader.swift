//
//  cellHeader.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 21/05/22.
//

import Foundation
import UIKit
import ExpyTableView

class cellHeader : UITableViewCell , ExpyTableViewHeaderCell{
    
    @IBOutlet var lblTitle : UILabel!
    
    @IBOutlet var imgDropdown : UIImageView!
    
    @IBOutlet var viewLine : UIView!

    func changeState(_ state: ExpyState, cellReuseStatus cellReuse: Bool) {
        
        switch state {
        case .willExpand:
            print("WILL EXPAND")
            hideSeparator()
            self.imgDropdown.image = UIImage(named: "ic_UpArrow")
            self.viewLine.isHidden = true

        case .willCollapse:
            print("WILL COLLAPSE")
            self.imgDropdown.image = UIImage(named: "ic_DownArrow")
            self.viewLine.isHidden = false
            
        case .didExpand:
            print("DID EXPAND")
            
        case .didCollapse:
            showSeparator()
            print("DID COLLAPSE")
        }
    }

}
