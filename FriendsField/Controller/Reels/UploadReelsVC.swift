//
//  UploadReels.swift
//  FriendsField
//
//  Created by iMac on 24/08/22.
//

import UIKit
import UniformTypeIdentifiers
import AVKit
import AVFoundation

class UploadReelsVC: UIViewController {
    
    @IBOutlet var viewNavigation : UIView!
    
    @IBOutlet var imgVideoThum : UIImageView!
    
    @IBOutlet var txtViewCaption : UITextView!
    
    @IBOutlet var btnPlay : UIButton!
    @IBOutlet var btnUpload : UIButton!
    @IBOutlet var btnClose : UIButton!
    
    //MARK: - Variables
    var strVideoName = ""
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SetupUI()
    }
    
    override func viewDidLayoutSubviews() {
        self.viewNavigation.addBottomShadow()
    }
    
    //MARK: - Private Method
    func SetupUI() {
        
        self.imagePicker.delegate = self
        self.btnPlay.isHidden = true
        self.btnClose.isHidden = true
    }
    
    func openGallary() {
        
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.mediaTypes = ["public.movie"]
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func GetVideoFromURL(videoName : String) {
        //With API Thumbnail
        self.btnUpload.isHidden = true
        self.btnPlay.isHidden = true
        self.btnClose.isHidden = true
        let str = DocumentDirectory().GetVideo(videoName: videoName)
        let fileUrl = URL(fileURLWithPath: str)
        self.getThumbnailImageFromVideoUrl(url: fileUrl) { (thumbNailImage) in
            self.imgVideoThum.image = thumbNailImage
            if self.imgVideoThum.image != nil {
                self.btnPlay.isHidden = false
                self.btnClose.isHidden = false
            } else {
                self.btnUpload.isHidden = true
            }
        }
        
    }
    
    //MARK: - IBActions
    @IBAction func btnBackPressed(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSharePressed(_ sender : UIButton) {
    }
    
    @IBAction func btnPlayPressed(_ sender : UIButton) {
        
        let str = DocumentDirectory().GetVideo(videoName: strVideoName)
        let player = AVPlayer(url: URL(fileURLWithPath: str))
        let playerController = AVPlayerViewController()
        playerController.player = player
        present(playerController, animated: true) {
            player.play()
        }
    }
    
    @IBAction func btnUploadVieoPressed(_ sender : UIButton) {
        
        openGallary()
    }
    
    @IBAction func btnClosePressed(_ sender : UIButton) {
        
        btnClose.isHidden = true
        btnPlay.isHidden = true
        btnUpload.isHidden = false
        imgVideoThum.image = nil
        strVideoName = ""
    }

}

extension UploadReelsVC : UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.dismiss(animated: true, completion: nil)
        guard let movieUrl = info[.mediaURL] as? URL else { return }
        print(movieUrl)
        let timestamp = NSDate().timeIntervalSince1970
        let s_Name = "fileVideo"
        let uuid = "\(timestamp)"
        let f_Name = "\(s_Name)_\(uuid)"
        let fileName: String = f_Name + (".mp4")
        strVideoName = fileName
        if let videoData = NSData(contentsOf: movieUrl) {
            DocumentDirectory().SaveVideo(videoData: videoData, videoName: fileName)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.GetVideoFromURL(videoName: fileName)
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getThumbnailImageFromVideoUrl(url: URL, completion: @escaping ((_ image: UIImage?)->Void)) {
        DispatchQueue.global().async { //1
            let asset = AVAsset(url: url) //2
            let avAssetImageGenerator = AVAssetImageGenerator(asset: asset) //3
            avAssetImageGenerator.appliesPreferredTrackTransform = true //4
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
    
}

extension UploadReelsVC : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Write a Caption" {
            textView.text = ""
        }
        
        if textView == self.txtViewCaption {
            self.txtViewCaption.becomeFirstResponder()
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Write a Caption"
        }
    }
    
}

