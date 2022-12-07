//
//  StatusVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 18/05/22.
//

import UIKit
import JXSegmentedView
import PixelSDK
import PhotosUI
import AVKit

class StatusVC: UIViewController {
    
    //MARK: - Variables
    @IBOutlet var tblStatusData : UITableView!
    
    @IBOutlet var statusSegment : ANSegmentIndicator!
    var indicators: [ANSegmentIndicator] = []
    
    let arrHeader = ["Resent Updates", "Viewed Status"]
    
    var viewModel: IGHomeViewModel = IGHomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SetupUI()
    }
    
    //MARK: - Private Method
    func SetupUI() {
        
        self.setupSegment(segmentView: self.statusSegment, Count: 3)
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            var progressInPercents = 1.0
            Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true) { timer in
                progressInPercents = progressInPercents + 7.0
                self.indicators.forEach {
                    $0.updateProgress(percent: progressInPercents)
                }
            }
        }
    }
    
    func setupSegment(segmentView : ANSegmentIndicator , Count : Int) {
        var settings = ANSegmentIndicatorSettings()
        settings.defaultSegmentColor = UIColor.gray
        settings.segmentBorderType = .round
        settings.segmentsCount = Count
        settings.segmentWidth = 2
        settings.segmentColor = UIColor.init(hexString: colors.ThemeSky)
        segmentView.settings = settings
        indicators.append(segmentView)
    }
    
    //MARK: - IBActions
    @IBAction func btnBackPressed(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnMyStatusPressed(_ sender : UIButton) {
        
        DispatchQueue.main.async {
            if let stories = self.viewModel.getStories(), let stories_copy = try? stories.copy().myStory, stories_copy.count > 0 && stories_copy[0].snaps.count > 0 {
                let storyPreviewScene = IGStoryPreviewController.init(stories: stories_copy, handPickedStoryIndex: 0, handPickedSnapIndex: 0)
                self.present(storyPreviewScene, animated: true, completion: nil)
            } else {
                print("Redirect to Add Story screen")
            }
        }
    }
    
    @IBAction func btnCameraPressed(_ sender : UIButton) {
        
        let container = ContainerController(modes: [.library, .video])
        container.editControllerDelegate = self
        container.libraryController.fetchPredicate = NSPredicate(format: "mediaType == %d", PHAssetMediaType.video.rawValue)
        container.libraryController.draftMediaTypes = [.video]
        let nav = UINavigationController(rootViewController: container)
        nav.modalPresentationStyle = .fullScreen
        
        self.present(nav, animated: true, completion: nil)
        
        
        //For Images..
        /* let photoEditor = PhotoEditorViewController(nibName:"PhotoEditorViewController",bundle: Bundle(for: PhotoEditorViewController.self))
         photoEditor.photoEditorDelegate = self
         photoEditor.image = UIImage(named: "img_DummyProduct")
         //Colors for drawing and Text, If not set default values will be used
         //photoEditor.colors = [.red, .blue, .green]
         
         //Stickers that the user will choose from to add on the image
         for i in 0...91{
         photoEditor.stickers.append(UIImage(named: "\(i)") ?? UIImage())
         }
         
         //To hide controls - array of enum control
         photoEditor.hiddenControls = [.save, .share , .draw]
         photoEditor.modalPresentationStyle = UIModalPresentationStyle.currentContext
         present(photoEditor, animated: true, completion: nil) */
    }
    
}

extension StatusVC: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}

extension StatusVC : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.arrHeader.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return viewModel.numberOfItemsInSection(section)
        } else {
            return viewModel.numberOfItemsInSection(section)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 40))
        let label = UILabel()
        label.frame = CGRect.init(x: 0, y: 15, width: headerView.frame.width, height: headerView.frame.height - 15)
        label.text = arrHeader[section]
        label.font = UIFont.Roboto(size: 16, weight: .Bold)
        label.textColor = .black
        
        headerView.addSubview(label)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = tblStatusData.dequeueReusableCell(withIdentifier: "cellStatus") as? cellStatus {
                let story = viewModel.cellForItemAt(indexPath: indexPath)
                cell.lblName.text = story?.user.name
                if let picture = story?.user.picture {
                    cell.imgProfile.setImage(url: picture)
                }
                
                self.setupSegment(segmentView: cell.viewStatus, Count:3)
                
                return cell
            }
        } else {
            if let cell = tblStatusData.dequeueReusableCell(withIdentifier: "cellViewStatus") as? cellViewStatus {
                
                let story = viewModel.cellForItemAt(indexPath: indexPath)
                cell.lblName.text = story?.user.name
                if let picture = story?.user.picture {
                    cell.imgProfile.setImage(url: picture)
                }
                self.setupSegment(segmentView: cell.viewStatus, Count: 2)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        DispatchQueue.main.async {
            if let stories = self.viewModel.getStories(), let stories_copy = try? stories.copy().otherStories {
                let storyPreviewScene = IGStoryPreviewController.init(stories: stories_copy, handPickedStoryIndex:  indexPath.row, handPickedSnapIndex: 0)
                self.present(storyPreviewScene, animated: true, completion: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}

extension StatusVC : UITextFieldDelegate {
    
}

//For Images Delegate
/*extension StatusVC: PhotoEditorDelegate {
 
 func doneEditing(image: UIImage) {
 
 print("\n\nEdited Image : \(image) ----\n")
 }
 
 func canceledEditing() {
 print("Canceled")
 }
 }*/

extension StatusVC : EditControllerDelegate {
    
    func editController(_ editController: EditController, didLoadEditing session: Session) {
        // Called after the EditController's view did load.
    }
    
    func editController(_ editController: EditController, didFinishEditing session: Session) {
        // Called when the Next button in the EditController is pressed.
        // Use this time to either dismiss the UINavigationController, or push a new controller on.
        
        /*Pass Video*/
        
        if let video = session.video {
           print("Beginning video export")
                 
            showProgress("")

           VideoExporter.shared.export(video: video, progress: { progress in
               print("Export Progress: \(progress)")
                              
           }, completion: { (error) in
                              
               if let error = error {
                   print("Unable to export video: \(error)")
                   return
               }
               
               print("Finished video export to file: \(video.exportedVideoURL)")
               
               // YOUR VIDEO UPLOAD LOGIC GOES HERE
               let timestamp = NSDate().timeIntervalSince1970
               let s_Name = "fileVideo"
               let uuid = "\(timestamp)"
               let f_Name = "\(s_Name)_\(uuid)"
               let fileName: String = f_Name + (".mp4")

               var VIDEODATA = NSData()
               if let videoData = NSData(contentsOf: video.exportedVideoURL) {
                   VIDEODATA = videoData
               }
               DocumentDirectory().SaveVideo(videoData: VIDEODATA, videoName: fileName)
               
               let str = DocumentDirectory().GetVideo(videoName: fileName)
               let videoURL = URL(fileURLWithPath: str)

               guard let musicURL = Bundle.main.url(forResource: "sample", withExtension: "mp3")
               else { return }
               
               let videoAsset = AVAsset(url: videoURL)
               let musicAsset = AVAsset(url: musicURL)
               
               
               DispatchQueue.global().async {
                   KVVideoManager.shared.merge(video: videoAsset, withBackgroundMusic: musicAsset) {[weak self] (outputURL, error) in
                       guard let `self` = self else { return }
                       
                       DispatchQueue.main.async {
                           dismissProgress()
                           print(outputURL)
                           if let error = error {
                               print("Error:\(error.localizedDescription)")
                           } else if let url = outputURL {
                               print("Video URL : \(url)")
                               self.dismiss(animated: true)
                               self.openPreviewScreen(url)
                           }
                       }
                   }
               }
           })
       }
        
        //let controller = PostController()
        //controller.session = session
        //editController.navigationController?.pushViewController(controller, animated: true)
    }
    
    func editController(_ editController: EditController, didCancelEditing session: Session?) {
        // Called when the back button in the EditController is pressed.
    }
    
    func openPreviewScreen(_ videoURL:URL) -> Void {
        let player = AVPlayer(url: videoURL)
        let playerController = AVPlayerViewController()
        playerController.player = player
        playerController.modalPresentationStyle = .fullScreen
        
        present(playerController, animated: true, completion: {
            player.play()
        })
    }
    
}
