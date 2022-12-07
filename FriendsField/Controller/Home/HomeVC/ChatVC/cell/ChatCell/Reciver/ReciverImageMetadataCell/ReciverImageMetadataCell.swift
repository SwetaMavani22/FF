//
//  ReciverImageMetadataCell.swift
//  StarCall
//
//  Created by Techno Exponent10 on 20/04/22.
//  Copyright © 2022 Techno Exponent. All rights reserved.
//

import UIKit

class ReciverImageMetadataCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblTime: UILabel!

    @IBOutlet var imgUser: UIImageView!
    @IBOutlet var imgSend : UIImageView!

    @IBOutlet var tblVw: UITableView!

    @IBOutlet var viewBG: UIView!
    
    @IBOutlet var hght_Tbl: NSLayoutConstraint!
    @IBOutlet var img_Width: NSLayoutConstraint!
    @IBOutlet var img_Hght: NSLayoutConstraint!
    
    var taleVW : UITableView = UITableView()
    var tableHeight = 0.0
}
    /*
    var mssg : ChatRowsData!
    var lbl : UILabel = UILabel()
    var lbl2 : UILabel = UILabel()
    var coommingFrom = "D"
    var pmssg : ChatData!
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        prepareUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private func prepareUI()
    {
//        msgLbl.backgroundColor = .clear
        timeLbl.apply(style: .smallAshText)
        userImageView.roundAllCorners(of: userImageView.bounds.height/2)
        nameLbl.roundAllCorners(of: nameLbl.bounds.height/2)
    }
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        utility.hideLoader()
        lblBgView?.backgroundColor = isDarkModeOn ? .black : UIColor(hexString: "#ffffff")
//        msgLbl.backgroundColor = .clear
//        msgLbl.apply(style: .normalWhiteText)
        lblBgView?.roundAllCorners(of: 5)
    }
    //MARK:-SETUP META DATA
    func setUpTableView()
    {
        tblVw.dataSource = self
        tblVw.delegate = self
        tblVw.rowHeight = UITableView.automaticDimension
        tblVw.register(with: Cell.linkShareCell)
        tblVw.reloadData()
    }
    func setUpMetaDataImage(mssg : ChatRowsData)
    {
        
        var linkStr : [String] = [String]()
        for mData in mssg.metaData!
        {
            let str = mData.url ?? ""
            linkStr.append(str)
        }
//        msgLbl.hyperLink(originalText: mssg.message ?? "", linkTextsAndTypes: linkStr)
        self.mssg = mssg
        setUpTableView()
        setUpTblHeight()
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
    
    func setUpChatImage(mssg : ChatRowsData)
    {
        coommingFrom = "D"
//        msgLbl?.text = mssg.message
        timeLbl.text = utility.getChatTimeFromString(timeString: mssg.updatedAt ?? "")
        tableHeight = taleVW.frame.size.height
        let imageStr = mssg.fileName ?? ""
        setUpImageSize(url_Str: practitionerBaseImageurl + imageStr)
        downloadfromCellUrl(url_Str: practitionerBaseImageurl + imageStr)
        setUpMetaDataImage(mssg : mssg)
        nameLbl.text = mssg.sender?.name?.firstLetter().uppercased() ?? ""
        timeLbl.text = utility.getChatTimeFromString(timeString: mssg.updatedAt ?? "")
    }
    
    func setupPatientDoctorImage(mssg : ChatData)
    {
        coommingFrom = "P"
        tableHeight = taleVW.frame.size.height
        let imageStr = mssg.fileName ?? ""
        setUpImageSize(url_Str: practitionerBaseImageurl + imageStr)
        downloadfromCellUrl(url_Str: practitionerBaseImageurl + imageStr)
    }
    
    func downloadfromCellUrl(url_Str: String){
        let str = url_Str.replacingOccurrences(of: " ", with: "%20")
        //        guard let url = URL(string: str) else { return }
        //        img_Send.kf.indicatorType = .activity
        //        img_Send.kf.setImage(with: url, completionHandler:  { [self] result in
        //            // `result` is either a `.success(RetrieveImageResult)` or a `.failure(KingfisherError)`
        //            switch result {
        //            case .success(let value):
        //                img_Send.image = value.image
        //                //  img_Send.image = img_Send.image?.withRoundedCorners(radius: 60)
        //
        //
        //                break
        //            case .failure(let _):
        //
        //                //  img_Send.image = UIImage(named: "Group 26")
        //                //setUpImageSize()
        //                break
        //            }
        //        })
        
        img_Send.sd_setImage(with: URL(string: str), placeholderImage: UIImage(named: "placeholder.png"))
    }
    
    func setUpImageSize(url_Str: String/*,mssg : ChatRowsData*/)
    {
        img_Hght.constant =  tableHeight / 2
        img_Width.constant = self.frame.size.width / 2
    }
    
}

extension ReciverImageMetadataCell : UITableViewDelegate,UITableViewDataSource{
    
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
            /*cell?.image_Icon.image = nil
            let ob = mssg.metaData?[indexPath.row]
            cell?.image_Icon.downloadfromUrl(url_Str: ob?.logo ?? "")
            cell?.lbl_Disp.text = ob?.description
            cell?.lbl_Title.text = ob?.title
            cell?.lbl_OrigionalLink.text = ob?.originalUrl
            cell?.setUpSenderBackGround()
            lbl = (cell?.lbl_Disp)!
            lbl2 = (cell?.lbl_Title)!*/
            
            cell?.image_Icon.image = nil
            let ob = mssg.metaData?[indexPath.row]
            cell?.image_Icon.kf.setImage(with: URL(string: ob?.image ?? ""),placeholder: UIImage(named: ""))
            cell?.image_Top_icon.kf.setImage(with: URL(string: ob?.logo ?? ""),placeholder: UIImage(named: "Group 26"))
            
            cell?.lbl_Disp.text = ob?.originalUrl
            cell?.lbl_Title.text = ob?.publisher
            cell?.setUpSenderBackGround()
            lbl = (cell?.lbl_Disp)!
            lbl2 = (cell?.lbl_Title)!

        }else
        {
            /*cell?.image_Icon.image = nil
            let ob = pmssg.metaData[indexPath.row]
            cell?.image_Icon.downloadfromUrl(url_Str: ob.logo ?? "")
            cell?.lbl_Disp.text = ob.description
            cell?.lbl_Title.text = ob.title
            cell?.lbl_OrigionalLink.text = ob.originalUrl
            cell?.setUpSenderBackGround()
            lbl = (cell?.lbl_Disp)!
            lbl2 = (cell?.lbl_Title)!*/
            
            cell?.image_Icon.image = nil
            let ob = pmssg.metaData[indexPath.row]
            cell?.image_Icon.kf.setImage(with: URL(string: ob.image ?? ""))
            cell?.image_Top_icon.kf.setImage(with: URL(string: ob.logo ?? ""))
            cell?.lbl_Disp.text = ob.originalUrl
            cell?.lbl_Title.text = ob.publisher
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
