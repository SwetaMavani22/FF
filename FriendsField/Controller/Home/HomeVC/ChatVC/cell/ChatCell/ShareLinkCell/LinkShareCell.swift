//
//  ShareLinkCe.swift
//  StarCall
//
//  Created by Techno Exponent on 26/04/22.
//  Copyright © 2022 Techno Exponent. All rights reserved.
//

import Foundation
import UIKit

class LinkShareCell : UITableViewCell {

    @IBOutlet var lbl_Disp: UILabel!
    @IBOutlet var lbl_Title: UILabel!

    @IBOutlet var bckVw: UIView!
    
    @IBOutlet var image_Icon: UIImageView!
    @IBOutlet var image_Top_icon: UIImageView!

    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setUpSenderBackGround()
    {
        //bckVw.backgroundColor = SCColorType.theme.color
        bckVw.backgroundColor = UIColor(hexString: "#ffffff")
    }
    
}
