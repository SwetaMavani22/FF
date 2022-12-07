//
//  SCSenderMsgCell.swift
//  StarCall
//
//  Created by Soumil on 7/20/20.
//  Copyright © 2020 Techno Exponent. All rights reserved.
//

import UIKit

class SenderMsgCell: UITableViewCell {

    @IBOutlet var viewBG: UIView!
    
    @IBOutlet var lblMessage: UILabel!
    @IBOutlet var lblTime: UILabel!
    
    @IBOutlet var imgTick: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareUI()
    }

    func prepareUI() {
        
        lblMessage.apply(style: .normalBlackText)
        lblMessage.backgroundColor = .clear

        lblTime.apply(style: .smallAshText)
        
        viewBG.backgroundColor = UIColor(hexString: colors.ThemeSky).withAlphaComponent(0.2)
        viewBG.layer.cornerRadius = 5.0
        //viewBG?.roundCorners(corners: [.layerMaxXMinYCorner, .layerMinXMinYCorner,.layerMinXMaxYCorner], radius: 5)
    }
}
