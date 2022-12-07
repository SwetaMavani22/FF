//
//  PdfCell.swift
//  StarCall
//
//  Created by Techno Exponent10 on 25/01/22.
//  Copyright © 2022 Techno Exponent. All rights reserved.
//

import UIKit

class PdfCell: UITableViewCell {
    
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet var lblPdfName: UILabel!
    @IBOutlet var lblPdfSize: UILabel!

    @IBOutlet var btnMore: UIButton!

    @IBOutlet var viewChat: UIView!
    
    @IBOutlet var imgPDF : UIImageView!
    @IBOutlet weak var imgTick: UIImageView!

}
    /// ------ Start Comment --------
    
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
    }
    
    private func prepareUI() {
        msgLbl.backgroundColor = .clear
        // msgLbl.apply(style: .normalWhiteText)
        timeLbl.apply(style: .smallAshText)
        vwChat?.roundCorners(corners: [.layerMaxXMinYCorner, .layerMinXMinYCorner,.layerMinXMaxYCorner], radius: 15)
    }
    
    override func prepareForReuse() {
        imgPDF.image = nil
        lbl_PdfName.text = ""
    }
    
    /// ------ Start Comment --------

    /*
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
    }*/
    /// ------ End Comment --------
}

extension PdfCell {
    
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
} */
