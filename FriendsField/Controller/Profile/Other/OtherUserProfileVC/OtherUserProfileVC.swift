//
//  UserProfileVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 18/05/22.
//

import UIKit
import JXSegmentedView

class OtherUserProfileVC: UIViewController {
    
    //MARK: - Variables
    @IBOutlet var viewSegmentVC: UIView!
    @IBOutlet var viewBussines: UIView!
    @IBOutlet var viewAudio: UIView!
    @IBOutlet var viewVideo: UIView!
    @IBOutlet var viewSocial: UIView!
    
    @IBOutlet var imgProfile: UIImageView!
    
    @IBOutlet var lblUserName: UILabel!
    @IBOutlet var lblUserInfo: UILabel!
    
    @IBOutlet var btnInsta : UIButton!
    @IBOutlet var btnLinkedin : UIButton!
    @IBOutlet var btnTwitter : UIButton!
    @IBOutlet var btnFacebook : UIButton!
    @IBOutlet var btnPintrest : UIButton!
    @IBOutlet var btnYoutube : UIButton!

    @IBOutlet weak var viewSegmentHeader : JXSegmentedView!
    var listContainerView: JXSegmentedListContainerView!
    var segmentedDataSource: JXSegmentedBaseDataSource!
    
    let userPersonalInfoVC = UIStoryboard.instantiateViewController(storyborad: .main,withViewClass: OtherUserPersonalInfoVC.self)
    let userBussinesInfoVC = UIStoryboard.instantiateViewController(storyborad: .main,withViewClass: OtherUserBusinessInfoVC.self)
    let reelsVC = UIStoryboard.instantiateViewController(storyborad: .main,withViewClass: ReelsVC.self)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SetupUI()
    }
    
    //MARK: - Private Method
    func SetupUI() {
        
        self.TopSliderSetUp()
    }
    
    func TopSliderSetUp() {
        
        var titles = [String]()
        if GlobalUserData.isBusinessProfileRegistered {
            titles = ["Personal Info", "Business Info" , "My Reels"]
        } else {
            titles = ["Personal Info"]
        }
        
        let dataSource = JXSegmentedTitleDataSource()
        dataSource.itemWidth = (viewSegmentHeader.frame.size.width / 3)
        dataSource.itemSpacing = 0
        dataSource.isTitleColorGradientEnabled = true
        dataSource.titles = titles
        dataSource.titleNormalFont = UIFont.Roboto(size: 18, weight: .Bold)
        dataSource.titleSelectedFont = UIFont.Roboto(size: 18, weight: .Bold)
        dataSource.titleSelectedColor = UIColor.init(hexString: colors.ThemeSky)
        dataSource.titleNormalColor = UIColor.black.withAlphaComponent(1)
        self.segmentedDataSource = dataSource
        
        let indicator = JXSegmentedIndicatorLineView()
        indicator.indicatorPosition = .bottom
        indicator.indicatorColor = UIColor.clear
        self.viewSegmentHeader.indicators = [indicator]
        
        viewSegmentHeader.backgroundColor = .white
        viewSegmentHeader.dataSource = segmentedDataSource
        viewSegmentHeader.delegate = self
        
        listContainerView = JXSegmentedListContainerView(dataSource: self)
        viewSegmentHeader.listContainer = listContainerView
        viewSegmentVC.addSubview(listContainerView)
        listContainerView.translatesAutoresizingMaskIntoConstraints = false
        listContainerView.topAnchor.constraint(equalTo: viewSegmentVC.topAnchor).isActive = true
        listContainerView.bottomAnchor.constraint(equalTo: viewSegmentVC.bottomAnchor).isActive = true
        listContainerView.leadingAnchor.constraint(equalTo: viewSegmentVC.leadingAnchor).isActive = true
        listContainerView.trailingAnchor.constraint(equalTo: viewSegmentVC.trailingAnchor).isActive = true
    }
    
    //MARK: - IBActions
    @IBAction func btnBackPressed(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnVoicePressed(_ sender : UIButton) {
    }
    
    @IBAction func btnVideoPressed(_ sender : UIButton) {
    }
    
    @IBAction func btnBussinesPressed(_ sender : UIButton) {
    }
    
    @IBAction func btnInstaPressed(_ sender : UIButton) {
    }
    
    @IBAction func btnLinkedInPressed(_ sender : UIButton) {
    }
    
    @IBAction func btnTwitterPressed(_ sender : UIButton) {
    }
    
    @IBAction func btnFaceBookPressed(_ sender : UIButton) {
    }
    
    @IBAction func btnUserProfilePressed(_ sender : UIButton) {
    }
    
    @IBAction func btnYoutubePressed(_ sender : UIButton) {
    }

    @IBAction func btnPrintrestPressed(_ sender : UIButton) {
    }

}

extension OtherUserProfileVC: JXSegmentedViewDelegate {
    
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        
    }
}

extension OtherUserProfileVC: JXSegmentedListContainerViewDataSource {
    
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        if let titleDataSource = viewSegmentHeader.dataSource as? JXSegmentedBaseDataSource {
            return titleDataSource.dataSource.count
        }
        return 0
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        
        switch index {
        case 0 :
            userPersonalInfoVC.ParentView = self.view
            return userPersonalInfoVC
        case 1 :
            userBussinesInfoVC.ParentView = self.view
            return userBussinesInfoVC
        case 2:
            return reelsVC
        default:
            userPersonalInfoVC.ParentView = self.view
            return userPersonalInfoVC
        }
    }
}
