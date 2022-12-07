//
//  ReciveChatImageCell.swift
//  StarCall
//
//  Created by Techno Exponent10 on 28/01/22.
//  Copyright © 2022 Techno Exponent. All rights reserved.
//

import UIKit

class ReciveChatImageCell: UITableViewCell {
    
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblName: UILabel!

    @IBOutlet weak var imgTick: UIImageView!
    @IBOutlet var imgSend: UIImageView!
    @IBOutlet weak var imgUser: UIImageView!
    
    @IBOutlet var viewChat: UIView!
    
    @IBOutlet var img_Width: NSLayoutConstraint!
    @IBOutlet var img_Hght: NSLayoutConstraint!
    
    var taleVW : UITableView = UITableView()
    var tableHeight = 0.0
}
/*
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    private func prepareUI() {
        
        userImageView.roundAllCorners(of: userImageView.bounds.height/2)
        nameLbl.roundAllCorners(of: nameLbl.bounds.height/2)
        timeLbl.apply(style: .smallAshText)
        
        vwChat.roundCorners(corners: [.layerMaxXMinYCorner, .layerMinXMinYCorner,.layerMaxXMaxYCorner], radius: 15)
       
        img_Send.translatesAutoresizingMaskIntoConstraints = false
      
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
        tableHeight = taleVW.frame.size.height
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
        let imageStr = mssg.fileName ?? ""
        setUpImageSize(url_Str: practitionerBaseImageurl + imageStr/*,mssg: mssg*/)
        downloadfromCellUrl(url_Str: practitionerBaseImageurl + imageStr)
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
    
    func setupPatientDoctorImage(mssg : ChatData)
    {
        tableHeight = taleVW.frame.size.height
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
extension UIImage {
    func getImageRatio() -> CGFloat {
        let imageRatio = CGFloat(self.size.width / self.size.height)
        print("imageRatio \(self.size.width)")
        print("imageRatio \(imageRatio)")
        return imageRatio
    }
}
*/
