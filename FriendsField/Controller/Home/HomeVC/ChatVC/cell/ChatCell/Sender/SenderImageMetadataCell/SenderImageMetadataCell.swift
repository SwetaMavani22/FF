//
//  SenderImageMetadataCell.swift
//  StarCall
//
//  Created by Techno Exponent10 on 20/04/22.
//  Copyright © 2022 Techno Exponent. All rights reserved.
//

import UIKit
import Kingfisher

class SenderImageMetadataCell: UITableViewCell {
    
    @IBOutlet var tblVw: UITableView!
    
    @IBOutlet var viewBG: UIView?
    
    @IBOutlet var hght_Tbl: NSLayoutConstraint!
    @IBOutlet var img_Width: NSLayoutConstraint!
    @IBOutlet var img_Hght: NSLayoutConstraint!

    @IBOutlet var lblTime: UILabel!
    
    @IBOutlet var imgTick: UIImageView!
    @IBOutlet var imgSend: UIImageView!

    var taleVW : UITableView = UITableView()
    var tableHeight = 0.0
 
    func SetupImageFromUrl(url_Str: String){
        
        let str = url_Str.replacingOccurrences(of: " ", with: "%20")
        guard let url = URL(string: str) else { return }
        let image = DocumentDirectory().fetchImage(fileName: url.lastPathComponent)
        self.imgSend.image = image
        imgSend.kf.indicatorType = .activity
        imgSend.kf.setImage(with: url, placeholder: image)
    }
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
        prepareForReuse()
    }
    override func prepareForReuse()
    {
        super.prepareForReuse()
        utility.hideLoader()
        lblBgView?.backgroundColor = isDarkModeOn ? .black : UIColor(hexString: "#ffffff")
//        msgLbl.backgroundColor = .clear
        //msgLbl.apply(style: .normalWhiteText)
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
        //msgLbl.text = mssg.message ?? ""
        self.mssg = mssg
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
                hght = hght + h + h2
            }
        }else if(pmssg.metaData.count > 0)
        {
            hght = CGFloat(67 * (pmssg.metaData.count ?? 0))
            for ob in pmssg.metaData
            {
                let h = lbl.requiredHeight(for: ob.description ?? "")
                let h2 = lbl2.requiredHeight(for: ob.title ?? "")
                hght = hght + h + h2
            }
        }
        
        
        hght_Tbl.constant = hght + 3
    }
    
    func setUpChatImage(mssg : ChatRowsData)
    {
        print(mssg.metaData?.count)
        coommingFrom = "D"
//        msgLbl?.text = mssg.message
        timeLbl.text = utility.getChatTimeFromString(timeString: mssg.updatedAt ?? "")
        tableHeight = taleVW.frame.size.height
        let imageStr = mssg.fileName ?? ""
        setUpImageSize(url_Str: practitionerBaseImageurl + imageStr)
        downloadfromCellUrl(url_Str: practitionerBaseImageurl + imageStr)
        if let status = mssg.status
        {
            tickImgView.image = UIImage(named: (status == 2) ? "chatTick" : "chatSingleTick")
        }
       setUpMetaDataImage(mssg : mssg)
        
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
        guard let url = URL(string: str) else { return }
        let image = DocumentDirectory().fetchImage(fileName: url.lastPathComponent)
        self.img_Send.image = image
        img_Send.kf.indicatorType = .activity
        img_Send.kf.setImage(with: url, placeholder: image)

        /*img_Send.isHidden = true
        viewDummy.isHidden = true

        guard let url = URL(string: url_Str) else { return }
        fetchImage(from: url_Str, completionHandler: {(Imagedata) in
            if let data = Imagedata {
                DispatchQueue.main.async {
                    if UIImage(data: data) == nil {
                        let image = DocumentDirectory().fetchImage(fileName: url.lastPathComponent)
                        self.img_Upload.image = image
                        self.viewDummy.isHidden = false
                        self.img_Send.isHidden = true
                    } else {
                        self.viewDummy.isHidden = true
                        self.img_Send.isHidden = false
                        self.img_Send.image = UIImage(data: data)
                    }
                }
            }
        })*/
    }
    
    func fetchImage(from urlString: String, completionHandler: @escaping (_ data: Data?) -> ()) {
        let session = URLSession.shared
        guard let url = URL(string: urlString) else { return }
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("Error fetching the image! 😢")
                completionHandler(nil)
            } else {
                completionHandler(data)
            }
        }
        dataTask.resume()
    }

    func setUpImageSize(url_Str: String/*,mssg : ChatRowsData*/)
    {
        img_Hght.constant =  tableHeight / 2
        img_Width.constant = self.frame.size.width / 2
    }
    */

/* extension SenderImageMetadataCell : UITableViewDelegate,UITableViewDataSource{
    
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
    
} */
