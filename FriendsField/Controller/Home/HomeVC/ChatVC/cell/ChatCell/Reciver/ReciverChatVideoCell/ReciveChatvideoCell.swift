//
//  ReciveChatvideoCell.swift
//  StarCall
//
//  Created by Techno Exponent10 on 07/03/22.
//  Copyright © 2022 Techno Exponent. All rights reserved.
//

import UIKit
import AVKit
class PlayerView: UIView {
    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
        set {
            playerLayer.videoGravity = .resizeAspect
            playerLayer.player = newValue
        }
    }
    
    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    
    override static var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
}

class ReciveChatvideoCell: UITableViewCell {
    
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblName: UILabel!

    @IBOutlet weak var imgTick: UIImageView!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet var imgGallery: UIImageView!
    
    @IBOutlet var viewChat: UIView!
    @IBOutlet var viewVideoPlayer: UIView!
    @IBOutlet var viewInitial: UIView!
    
    var vc : UIViewController = UIViewController()
    var playerController : AVPlayerViewController? = nil
}
/*
    var vdoData : ChatRowsData?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        prepareUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
        override func prepareForReuse()
    {
        super.prepareForReuse()
        player.pause()
        player = AVPlayer()
        vw_Initial.isHidden = false
        utility.hideLoader()
    }
    private func prepareUI() {
        userImageView.roundAllCorners(of: userImageView.bounds.height/2)
        timeLbl.apply(style: .smallAshText)
        nameLbl.roundAllCorners(of: nameLbl.bounds.height/2)
        vwChat.roundCorners(corners: [.layerMaxXMinYCorner, .layerMinXMinYCorner,.layerMaxXMaxYCorner], radius: 15)
        
    }
    
    func setUpChatImage(mssg : ChatRowsData)
    {
        vdoData = mssg
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
        let str = practitionerBaseImageurl + (vdoData?.fileName?.replacingOccurrences(of: " ", with: "%20") ?? "")
        guard let url = URL(string: str) else { return }
        didSetThumbilImage(urlStr : url)
    }
    
    func setUpPatientDoctorVdo(mssg : ChatData)
    {
        vdoData = ChatRowsData(id: mssg.id, roomID: mssg.roomID, senderID: mssg.senderID, message: mssg.message, fileName: mssg.fileName, thumbNail: mssg.fileName, mimeType: mssg.mimeType, status: mssg.status, createdAt: mssg.createdAt, updatedAt:  mssg.updatedAt, senderN: mssg.senderN, senderP2P: mssg.senderP2P, metaData: mssg.metaData, img_Width: 0.0, img_Height: 0.0)
        
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
    func setUpVideoPlayer()
    {
       
    }
    
    @IBAction func playVideo(_ sender: UIButton)
    {
        if player.timeControlStatus == .playing
        {
            player.pause()
        }else
        {
            vw_Initial.isHidden = true
            let imageStr = vdoData?.fileName ?? ""
            let str = practitionerBaseImageurl + imageStr.replacingOccurrences(of: " ", with: "%20")
            guard let url = URL(string: str) else { return }
            let asset = AVAsset(url: url)
            setupVideoPlayer(filePath : url)
            
        }
        
 
    }
    
    
    @IBAction func goToFullImage(_ sender: UIButton)
    {
        
//        if player.timeControlStatus == .playing
//        {
//            player.pause()
//        }
//        
//        let imageStr = vdoData?.fileName ?? ""
//        let str = practitionerBaseImageurl + imageStr.replacingOccurrences(of: " ", with: "%20")
//        guard let url = URL(string: str) else { return }
//        let asset = AVAsset(url: url)
//        
//        var alertPopUp:VideoPlayerView = VideoPlayerView()
//        alertPopUp =  Bundle.main.loadNibNamed("VideoPlayerView", owner: self, options: nil)?[0] as! VideoPlayerView
//        alertPopUp.show()
//        alertPopUp.vc = vc
//        vc.view.addSubview(alertPopUp)
//        alertPopUp.videoPlay(filePath: asset as! AVURLAsset)
    }
    
    
    
    var player: AVPlayer = AVPlayer()
    func setupVideoPlayer(filePath : URL)
    {
        let asset = AVAsset(url: filePath)
        let item = AVPlayerItem(asset: asset)
        player = AVPlayer(playerItem: item)
        player.addObserver(self, forKeyPath: "timControlStatus", options: [.old, .new], context: nil)
        playerController = AVPlayerViewController()
        playerController?.player = player
        vc.addChild(playerController!)
        playerController?.view.frame = self.vdoPlayer.frame
        playerController?.view.frame.origin.x = 0
        playerController?.view.frame.origin.y = 0
        self.vdoPlayer.addSubview(playerController?.view ?? UIView())
        if #available(iOS 10.0, *) {
            playerController?.player?.playImmediately(atRate: 1.0)
        } else {
            playerController?.player?.play()
        }
        
    }
    
    func didSetThumbilImage(urlStr : URL)
    {
        getThumbnailImageFromVideoUrl(url: urlStr) { (thumbNailImage) in
            self.img_Galarey.image = thumbNailImage
        }
    }
    func getThumbnailImageFromVideoUrl(url: URL, completion: @escaping ((_ image: UIImage?)->Void)) {
        
        let wdth = img_Galarey.frame.width
        let height = img_Galarey.frame.height
        DispatchQueue.global().async { [self] in //1
            let asset = AVAsset(url: url) //2
            let avAssetImageGenerator = AVAssetImageGenerator(asset: asset) //3
            avAssetImageGenerator.appliesPreferredTrackTransform = true //4
            avAssetImageGenerator.maximumSize = CGSize(width: wdth, height: height)
            let thumnailTime = CMTimeMake(value: 2, timescale: 1) //5
            do {
                let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumnailTime, actualTime: nil) //6
                let thumbNailImage = UIImage(cgImage: cgThumbImage) //7
                DispatchQueue.main.async { //8
                    completion(thumbNailImage) //9
                }
            } catch {
                print(error.localizedDescription) //10
                DispatchQueue.main.async {
                    completion(nil) //11
                }
            }
        }
    }
    
    
    
    var loader : UIActivityIndicatorView = UIActivityIndicatorView()
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "timeControlStatus", let change = change, let newValue = change[NSKeyValueChangeKey.newKey] as? Int, let oldValue = change[NSKeyValueChangeKey.oldKey] as? Int {
            let oldStatus = AVPlayer.TimeControlStatus(rawValue: oldValue)
            let newStatus = AVPlayer.TimeControlStatus(rawValue: newValue)
            if newStatus != oldStatus {
                DispatchQueue.main.async
                { [self] in
                    if newStatus == .playing || newStatus == .paused {
                       print("Start.........")

                        utility.hideLoader()
                    } else {
                       print("Waiting.........")
                       utility.showLoader(in: vdoPlayer)
                    }
                }
            }
        }
    }
}
*/
