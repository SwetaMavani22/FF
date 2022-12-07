//
//  ReciveChatPdfCell.swift
//  StarCall
//
//  Created by Techno Exponent10 on 28/01/22.
//  Copyright © 2022 Techno Exponent. All rights reserved.
//

import UIKit

class ReciveChatPdfCell: UITableViewCell {
    
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet var lblPdfSize: UILabel!
    @IBOutlet var lblPdfName: UILabel!

    @IBOutlet weak var imgTick: UIImageView!
    @IBOutlet var imgPDF : UIImageView!
    @IBOutlet weak var imgUser: UIImageView!

    @IBOutlet var pdfBtn: UIButton!
    @IBOutlet var btnMore: UIButton!

    @IBOutlet var viewChat: UIView!
}
/*
    var chatRowsData : ChatRowsData!
    var chatData : ChatData!
    var vc : SCBaseViewController!
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private func prepareUI() {
        msgLbl.backgroundColor = .clear
        //  msgLbl.apply(style: .normalWhiteText)
        timeLbl.apply(style: .smallAshText)
        vwChat.roundCorners(corners: [.layerMaxXMinYCorner, .layerMinXMinYCorner,.layerMaxXMaxYCorner], radius: 15)
        
    }
    
    func SetUpThumbnail() {
        
        DispatchQueue.global(qos: .userInitiated).async {
            let fname = self.chatRowsData.fileName?.replacingOccurrences(of: " ", with: "%20")
            let newUrl = URL(string: "https://doctors-appointment.s3-ap-southeast-2.amazonaws.com/uploads/profileimage/\(fname ?? "")")
            self.fileSize(forURL : newUrl)
            let img = pdfThumbnail(url: newUrl ?? URL(fileURLWithPath: ""))
            DispatchQueue.main.async {
                self.imgPDF.image = img
            }
        }
    }

    @IBAction func didFileDownload(_ sender: UIButton)
    {
        utility.showLoaderWithText(in: vc.view)
        
        SCService.downloadImageAWS3(fileName: (chatData != nil) ? chatData.fileName ?? "" : chatRowsData.fileName ?? "",contentType: "", lbl: utility.hud.textLabel, completion: { [self] (success, url)  in
            utility.hideLoader()
            if success == true, let mediaUrl = url {
                print("Downloaded succefully......")
                
            } else {
                
                print("Downloaded un succefully......")
            }
            
        })
    }
    func hideShowVwChat()
    {
        if(msgLbl.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0 > 0)
        {
            vwChat.isHidden = false
        }else
        {
            vwChat.isHidden = true
        }
    }
    
    func setUpChatImage(mssg : ChatRowsData)
    {
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
    
    func setUpChatImage2(mssg : ChatData)
    {
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
    
}

extension ReciveChatPdfCell {
 
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
