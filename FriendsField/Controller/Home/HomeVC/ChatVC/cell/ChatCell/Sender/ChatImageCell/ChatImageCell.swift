//
//  ChatImageCell.swift
//  StarCall
//
//  Created by Techno Exponent10 on 24/01/22.
//  Copyright © 2022 Techno Exponent. All rights reserved.
//

import UIKit
import Kingfisher

class ChatImageCell: UITableViewCell {
    
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var imgTick: UIImageView!
    @IBOutlet var imgSend: UIImageView!
    
    @IBOutlet var viewChat: UIView!
    
    @IBOutlet var img_Width: NSLayoutConstraint!
    @IBOutlet var img_Hght: NSLayoutConstraint!
    
    var taleVW : UITableView = UITableView()
    var tableHeight = 0.0
    
    func SetupImageFromUrl(url_Str: String){
        
        let str = url_Str.replacingOccurrences(of: " ", with: "%20")
        guard let url = URL(string: str) else { return }
        let image = DocumentDirectory().fetchImage(fileName: url.lastPathComponent)
        self.imgSend.image = image
        imgSend.kf.indicatorType = .activity
        imgSend.kf.setImage(with: url, placeholder: image)
        //lblMessage.text = ""
        //viewChat.isHidden = true
        
        lblTime.apply(style: .smallAshText)
    }

}
/*
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    /// ------ Start Comment --------
    
    private func prepareUI() {
        msgLbl.backgroundColor = .clear
        timeLbl.apply(style: .smallAshText)
        vwChat?.roundCorners(corners: [.layerMaxXMinYCorner, .layerMinXMinYCorner,.layerMinXMaxYCorner], radius: 15)
    }
    
    func hideShowVwChat() {
        if(msgLbl.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0 > 0) {
            vwChat.isHidden = false
        } else {
            vwChat.isHidden = true
        }
    }
    
    /*
    func setUpChatImage(mssg : ChatRowsData){
        tableHeight = taleVW.frame.size.height
        let imageStr = mssg.fileName ?? ""
        setUpImageSize(url_Str: practitionerBaseImageurl + imageStr)
        downloadfromCellUrl(url_Str: practitionerBaseImageurl + imageStr)
    }
    
    func setupPatientDoctorImage(mssg : ChatData){
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
    }
    */
    /// ------ End Comment --------
    
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

    func setUpImageSize(url_Str: String) {
        
        img_Hght.constant =  tableHeight / 2
        img_Width.constant = self.frame.size.width / 2
    }
}
*/
