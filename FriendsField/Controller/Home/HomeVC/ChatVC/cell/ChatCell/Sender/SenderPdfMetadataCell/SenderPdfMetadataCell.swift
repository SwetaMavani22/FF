//
//  SenderPdfMetadataCell.swift
//  StarCall
//
//  Created by Techno Exponent10 on 20/04/22.
//  Copyright © 2022 Techno Exponent. All rights reserved.
//

import UIKit

class SenderPdfMetadataCell: UITableViewCell {
    
    @IBOutlet var tblVw: UITableView!

    @IBOutlet private weak var viewBG: UIView!

    @IBOutlet var hght_Tbl: NSLayoutConstraint!
    
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet var lblPdfName: UILabel!
    @IBOutlet var lblPdfSize: UILabel!

    @IBOutlet weak var imgTick: UIImageView!
    @IBOutlet var imgPDF : UIImageView!

    @IBOutlet var btnMore: UIButton!
    
}
    /*
    var mssg : ChatRowsData!
    var lbl : UILabel = UILabel()
    var lbl2 : UILabel = UILabel()
    var coommingFrom = "D"
    var pmssg : ChatData!
    
    var chatRowsData : ChatRowsData!
    var chatData : ChatData!
    var vc : SCBaseViewController!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        prepareUI()
        prepareForReuse()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    private func prepareUI()
    {
        //msgLbl.backgroundColor = .clear
        timeLbl.apply(style: .smallAshText)
    }
    override func prepareForReuse()
    {
        super.prepareForReuse()
        utility.hideLoader()
        lblBgView?.backgroundColor = isDarkModeOn ? .black : UIColor(hexString: "#ffffff")
        //msgLbl.backgroundColor = .clear
        //msgLbl.apply(style: .normalWhiteText)
        lblBgView?.roundAllCorners(of: 5)
    }
    
    func setUpChatImage(mssg : ChatRowsData)
    {
        coommingFrom = "D"
        //msgLbl?.text = mssg.message
        timeLbl.text = utility.getChatTimeFromString(timeString: mssg.updatedAt ?? "")
        
        let imageStr = mssg.fileName ?? ""
        lbl_PdfName.text = mssg.fileName
        DispatchQueue.global(qos: .userInitiated).async {
            let fname = mssg.fileName?.replacingOccurrences(of: " ", with: "%20")
            let newUrl = URL(string: "https://doctors-appointment.s3-ap-southeast-2.amazonaws.com/uploads/profileimage/\(fname ?? "")")
            self.fileSize(forURL : newUrl)
            let img = pdfThumbnail(url: newUrl ?? URL(fileURLWithPath: ""))
            DispatchQueue.main.async {
                self.imgPDF.image = img
            }
        }

        if let status = mssg.status
        {
            tickImgView.image = UIImage(named: (status == 2) ? "chatTick" : "chatSingleTick")
        }
        setUpMetaDataImage(mssg : mssg)
        
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
        //msgLbl.hyperLink(originalText: mssg.message ?? "", linkTextsAndTypes: linkStr)
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


extension SenderPdfMetadataCell : UITableViewDelegate,UITableViewDataSource{
    
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
            cell?.image_Icon.kf.setImage(with: URL(string: ob?.image ?? ""),placeholder: UIImage(named: ""))
            cell?.image_Top_icon.kf.setImage(with: URL(string: ob?.logo ?? ""),placeholder: UIImage(named: "Group 26"))
            
            cell?.lbl_Disp.text = ob?.originalUrl
            cell?.lbl_Title.text = ob?.publisher
            cell?.setUpSenderBackGround()
            lbl = (cell?.lbl_Disp)!
            lbl2 = (cell?.lbl_Title)!
        }else
        {
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

extension SenderPdfMetadataCell {
 
    func fileSize(forURL url: URL?)
    {
        var request = URLRequest(url: url!)
        request.httpMethod = "HEAD"

        URLSession.shared.dataTask(with: request) { [weak self] (_, response, _) in
            if let response = response {
                let size = response.expectedContentLength
                DispatchQueue.main.async {
                    self?.lbl_PdfSize.text = "\(humanReadableByteCount(bytes:Int(size))) PDF"
                }
            }
        }.resume()
    }
}
*/
