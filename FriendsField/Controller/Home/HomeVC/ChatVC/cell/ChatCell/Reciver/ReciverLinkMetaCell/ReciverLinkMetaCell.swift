//
//  ReciverLinkMetaCell.swift
//  StarCall
//
//  Created by Techno Exponent10 on 02/03/22.
//  Copyright © 2022 Techno Exponent. All rights reserved.
//

import UIKit
import CoreMIDI
import SwiftUI

class ReciverLinkMetaCell: UITableViewCell {

    @IBOutlet var tblVw: UITableView!
    
    @IBOutlet var viewBG: UIView!
    @IBOutlet var viewMessage: UIView!

    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblTime: UILabel!
    
    @IBOutlet var imgUser: UIImageView!
    
    @IBOutlet var hght_Tbl: NSLayoutConstraint!
}

/*
    var mssg : ChatRowsData!
    var lbl : UILabel = UILabel()
    var lbl2 : UILabel = UILabel()
    override func awakeFromNib()
    {
        super.awakeFromNib()
        prepareUI()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    private func prepareUI() {
        lblBgView?.backgroundColor = UIColor(hexString: "#ffffff")
        userImageView.roundAllCorners(of: userImageView.bounds.height/2)
        //msgLbl.backgroundColor = .clear
        //msgLbl.apply(style: .normalWhiteText)
        timeLbl.apply(style: .smallAshText)
        nameLbl.roundAllCorners(of: nameLbl.bounds.height/2)
        lblBgView?.roundAllCorners(of: 5)
        vw_Msg.roundCorners(corners: [.layerMaxXMinYCorner, .layerMinXMinYCorner,.layerMaxXMaxYCorner], radius: 15.5)
    }
    
    
    func setUpTableView()
    {
        tblVw.dataSource = self
        tblVw.delegate = self
        tblVw.rowHeight = UITableView.automaticDimension
        tblVw.estimatedRowHeight = UITableView.automaticDimension
        tblVw.register(with: Cell.linkShareCell)
        tblVw.reloadData()
    }
    func setUpChatImage(mssg : ChatRowsData)
    {
        self.mssg = mssg
        var linkStr : [String] = [String]()
        for mData in mssg.metaData!
        {
            let str = mData.url ?? ""
            linkStr.append(str)
        }
        //msgLbl.hyperLink(originalText: mssg.message ?? "", linkTextsAndTypes: linkStr)
        nameLbl.text = mssg.sender?.name?.firstLetter().uppercased() ?? ""
        timeLbl.text = utility.getChatTimeFromString(timeString: mssg.updatedAt ?? "")
        if let imageName = mssg.sender?.profileImage, imageName != "" {
            userImageView.kf.setImage(with: URL(string: baseProfileImageUrl + imageName), placeholder: UIImage(systemName: "person.circle"))
            userImageView.isHidden = false
            nameLbl.isHidden = true
        } else {
            nameLbl.backgroundColor = UIColor(hexString: "#9A9A9A"/*messageData.sender?.bgColor ?? "#00708B"*/)
            nameLbl.textColor = UIColor(hexString: mssg.sender?.fgColor ?? "#ffffff")
            userImageView.isHidden = true
            nameLbl.isHidden = false
        }
        
        setUpTableView()
        setUpTblHeight()
    }
    func setUpTblHeight()
    {
        lbl.layoutIfNeeded()
        lbl2.layoutIfNeeded()
        var hght = CGFloat(218 * (mssg.metaData?.count ?? 0))
        for ob in mssg.metaData!
        {
            let h = lbl.requiredHeight(for: ob.description ?? "")
            let h2 = lbl2.requiredHeight(for: ob.title ?? "")
            //hght = hght + h + h2
        }
        hght_Tbl.constant = hght + 30
    }
    
}
extension ReciverLinkMetaCell : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mssg.metaData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.linkShareCell, for: indexPath) as? LinkShareCell
        let ob = mssg.metaData?[indexPath.row]
        //cell?.image_Icon.downloadfromUrl(url_Str: ob?.logo ?? "")
        cell?.image_Icon.kf.setImage(with: URL(string: ob?.image ?? ""),placeholder: UIImage(named: ""))
        cell?.image_Top_icon.kf.setImage(with: URL(string: ob?.logo ?? ""),placeholder: UIImage(named: ""))
        cell?.lbl_Disp.text = ob?.originalUrl
        cell?.lbl_Title.text = ob?.publisher
        //cell?.lbl_OrigionalLink.text = ob?.originalUrl
        lbl = (cell?.lbl_Disp)!
        lbl2 = (cell?.lbl_Title)!
        cell?.setUpSenderBackGround()
        
        return cell!
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let urlStr = mssg.metaData?[indexPath.row].originalUrl
        if let url = URL(string: urlStr ?? "")
        {
            UIApplication.shared.open(url)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        
    }
    
    
    
    
}
*/
