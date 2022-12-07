//
//  SenderLinkMetaCell.swift
//  StarCall
//
//  Created by Techno Exponent10 on 02/03/22.
//  Copyright © 2022 Techno Exponent. All rights reserved.
//

import UIKit

class SenderLinkMetaCell: UITableViewCell {
    
    @IBOutlet var tblVw: UITableView!
        
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var imgTick: UIImageView!
    @IBOutlet var hght_Tbl: NSLayoutConstraint!
   
}
    /*
    var mssg : ChatRowsData!
    var pmssg : ChatData!
    var coommingFrom = "D"
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
        lblBgView?.backgroundColor = isDarkModeOn ? .black : UIColor(hexString: "#ffffff")
        //userImageView.roundAllCorners(of: userImageView.bounds.height/2)
        //msgLbl.backgroundColor = .clear
        //msgLbl.apply(style: .normalWhiteText)
        timeLbl.apply(style: .smallAshText)
       // nameLbl.roundAllCorners(of: nameLbl.bounds.height/2)
        lblBgView?.roundAllCorners(of: 5)
        
    }
    func setUpTableView()
    {
        tblVw.dataSource = self
        tblVw.delegate = self
        tblVw.rowHeight = UITableView.automaticDimension
        tblVw.register(with: Cell.linkShareCell)
        tblVw.reloadData()
    }
    func setUpChatImage(mssg : ChatRowsData)
    {
        
        var linkStr : [String] = [String]()
        for mData in mssg.metaData!
        {
            let str = mData.url ?? ""
            linkStr.append(str)
        }
        //msgLbl.hyperLink(originalText: mssg.message ?? "", linkTextsAndTypes: linkStr)
        self.mssg = mssg
        setUpTableView()
        setUpTblHeight()
    }
    
    func setUpPatientMetaData(mssg : ChatData)
    {
        self.pmssg = mssg
        setUpTableView()
        setUpTblHeight()
    }
    
    func setUpTblHeight()
    {
        lbl.layoutIfNeeded()
        lbl2.layoutIfNeeded()
        var hght = 0.0
        if mssg.metaData?.count ?? 0 > 0
        {
            hght = CGFloat(218 * (mssg.metaData?.count ?? 0))
            for ob in mssg.metaData!
            {
                let h = lbl.requiredHeight(for: ob.description ?? "")
                let h2 = lbl2.requiredHeight(for: ob.title ?? "")
                //hght = hght + h + h2
            }
        }else if(pmssg.metaData.count > 0)
        {
            hght = CGFloat(67 * (pmssg.metaData.count ?? 0))
            for ob in pmssg.metaData
            {
                let h = lbl.requiredHeight(for: ob.description ?? "")
                let h2 = lbl2.requiredHeight(for: ob.title ?? "")
                //hght = hght + h + h2
            }
        }
        
        
        hght_Tbl.constant = hght + 30
    }
    
}
extension SenderLinkMetaCell : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if coommingFrom == "D"
        {
          return mssg.metaData?.count ?? 0
        }
        return pmssg.metaData.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.linkShareCell, for: indexPath) as? LinkShareCell
        if coommingFrom == "D"
        {
            cell?.image_Icon.image = nil
            let ob = mssg.metaData?[indexPath.row]
            //cell?.image_Icon.downloadfromUrl(url_Str: ob?.i ?? "")
            cell?.image_Icon.kf.setImage(with: URL(string: ob?.image ?? ""),placeholder: UIImage(named: ""))
            cell?.image_Top_icon.kf.setImage(with: URL(string: ob?.logo ?? ""),placeholder: UIImage(named: "Group 26"))
            
            cell?.lbl_Disp.text = ob?.originalUrl
            cell?.lbl_Title.text = ob?.publisher
            //cell?.lbl_OrigionalLink.text = ob?.originalUrl
            cell?.setUpSenderBackGround()
            lbl = (cell?.lbl_Disp)!
            lbl2 = (cell?.lbl_Title)!
            
        }else
        {
            cell?.image_Icon.image = nil
            let ob = pmssg.metaData[indexPath.row]
            //cell?.image_Icon.downloadfromUrl(url_Str: ob.logo ?? "")
            cell?.image_Icon.kf.setImage(with: URL(string: ob.image ?? ""))
            cell?.image_Top_icon.kf.setImage(with: URL(string: ob.logo ?? ""))
            cell?.lbl_Disp.text = ob.originalUrl
            cell?.lbl_Title.text = ob.publisher
            //cell?.lbl_OrigionalLink.text = ob.originalUrl
            cell?.setUpSenderBackGround()
            lbl = (cell?.lbl_Disp)!
            lbl2 = (cell?.lbl_Title)!
        }
        
        return cell!
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if coommingFrom == "D"
        {
            let urlStr = mssg.metaData?[indexPath.row].originalUrl
            if let url = URL(string: urlStr ?? "")
            {
               UIApplication.shared.open(url)
            }
        }else
        {
            let urlStr = mssg.metaData?[indexPath.row].originalUrl
            if let url = URL(string: urlStr ?? "")
            {
                UIApplication.shared.open(url)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        
    }
    
    
    
    
}
*/
