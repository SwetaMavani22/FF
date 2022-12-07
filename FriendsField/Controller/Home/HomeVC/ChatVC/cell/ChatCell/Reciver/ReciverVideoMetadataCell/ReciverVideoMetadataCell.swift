//
//  ReciverVideoMetadataCell.swift
//  StarCall
//
//  Created by Techno Exponent10 on 20/04/22.
//  Copyright © 2022 Techno Exponent. All rights reserved.
//

import UIKit
import AVKit
class ReciverVideoMetadataCell: UITableViewCell,AVPlayerViewControllerDelegate {
    
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet var imgUser: UIImageView!
    @IBOutlet var imgGallery: UIImageView!

    @IBOutlet var viewVideoPlayer: UIView!
    @IBOutlet var viewInitial: UIView!
    @IBOutlet var viewBg: UIView!

    @IBOutlet var hght_Tbl: NSLayoutConstraint!

    @IBOutlet var tblVw: UITableView!

    var player: AVPlayer = AVPlayer()
    var playerController : AVPlayerViewController? = nil
    var vc : UIViewController = UIViewController()
    
}
    
    /*
    var vdoData : ChatRowsData?
    var mssg : ChatRowsData!
    var lbl : UILabel = UILabel()
    var lbl2 : UILabel = UILabel()
    var coommingFrom = "D"
    var pmssg : ChatData!
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
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
        player.pause()
        player = AVPlayer()
        vw_Initial.isHidden = false
        utility.hideLoader()
        
        lblBgView?.backgroundColor = isDarkModeOn ? .black : UIColor(hexString: "#ffffff")
//        msgLbl.backgroundColor = .clear
//        msgLbl.apply(style: .normalWhiteText)
        timeLbl.apply(style: .smallAshText)
        lblBgView?.roundAllCorners(of: 5)
    }
    
    @IBAction func playVideo(_ sender: UIButton)
    {
        NotificationCenter.default.post(name: Notification.Name("vdosc"), object: nil)
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
    
    func setUpChatImage(mssg : ChatRowsData)
    {
        coommingFrom = "D"
//        msgLbl?.text = mssg.message
        timeLbl.text = utility.getChatTimeFromString(timeString: mssg.updatedAt ?? "")
        vdoData = mssg
        let str = practitionerBaseImageurl + (vdoData?.fileName?.replacingOccurrences(of: " ", with: "%20") ?? "")
        guard let url = URL(string: str) else { return }
        didSetThumbilImage(urlStr : url)
        setUpMetaDataImage(mssg :mssg)
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
        playerController?.delegate = self
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
    
    func playerViewController(_: AVPlayerViewController, willBeginFullScreenPresentationWithAnimationCoordinator: UIViewControllerTransitionCoordinator)
    {
        
        
    }
    func playerViewController(_: AVPlayerViewController, willEndFullScreenPresentationWithAnimationCoordinator: UIViewControllerTransitionCoordinator)
    {
        
    }
    
    
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


extension ReciverVideoMetadataCell : UITableViewDelegate,UITableViewDataSource{
    
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
