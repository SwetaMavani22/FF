//
//  UserProfileVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 19/05/22.
//

import UIKit
import JXSegmentedView
import Alamofire

class UserProfileVC: UIViewController {
    
    //MARK: - Variables
    @IBOutlet var viewSegmentVC: UIView!
    @IBOutlet var viewBussines: UIView!
    
    @IBOutlet var viewSocial: UIView!
    
    @IBOutlet var imgProfile: UIImageView!
    
    @IBOutlet var lblUserName: UILabel!
    @IBOutlet var lblUserInfo: UILabel!
    
    @IBOutlet var btnProfileEdit : UIButton!
    @IBOutlet var btnInsta : UIButton!
    @IBOutlet var btnLinkedin : UIButton!
    @IBOutlet var btnTwitter : UIButton!
    @IBOutlet var btnFacebook : UIButton!
    @IBOutlet var btnPintrest : UIButton!
    @IBOutlet var btnYoutube : UIButton!
    
    @IBOutlet weak var viewSegmentHeader : JXSegmentedView!
    var listContainerView: JXSegmentedListContainerView!
    var segmentedDataSource: JXSegmentedBaseDataSource!
    
    let userPersonalInfoVC = UIStoryboard.instantiateViewController(storyborad: .main,withViewClass: PersonalInfoVC.self)
    let userBussinesInfoVC = UIStoryboard.instantiateViewController(storyborad: .main,withViewClass: BussinesInfoVC.self)
    let reelsVC = UIStoryboard.instantiateViewController(storyborad: .main,withViewClass: ReelsVC.self)
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SetupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        FetchUserPersonalData()
    }
    
    //MARK: - Private Method
    func SetupUI() {
        
        self.imagePicker.delegate = self
        self.TopSliderSetUp()
    }
    
    func TopSliderSetUp() {
        
        let titles = ["Personal Info", "Business Info" , "My Reels"]
        let dataSource = JXSegmentedTitleDataSource()
        dataSource.itemWidth = (viewSegmentHeader.frame.size.width / 3)
        dataSource.itemSpacing = 0
        dataSource.isTitleColorGradientEnabled = true
        dataSource.titles = titles
        dataSource.titleNormalFont = UIFont.Roboto(size: 18, weight: .Bold)
        dataSource.titleSelectedFont = UIFont.Roboto(size: 18, weight: .Bold)
        dataSource.titleSelectedColor = UIColor.init(hexString: colors.ThemeSky)
        dataSource.titleNormalColor = UIColor.gray
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
    
    func FetchUserPersonalData() {
        
        if (isConnectedToNetwork()) {
            
            let headers: HTTPHeaders = ["authorization" : "bearer \(GlobalUserToken.token)", "Content-Type" : "application/json"]
            
            APIManager.APIGetCalling(API_URL.Url_FetchPersonalProfile, headers: headers) { (response) in
                let data = ModelPersonalProfile.init(dic: response as? [String:Any] ?? [:])
                if data.Status == API_URL.StatusCode {
                    GlobalUserData = data.Data
                    do {
                        let encodedData = try NSKeyedArchiver.archivedData(withRootObject: GlobalUserData, requiringSecureCoding: false)
                        Defualtss.set(encodedData, forKey: UDKey.kUserData)
                        self.SetUpData(data: data.Data)
                    } catch let error {
                        print("Something went wrong. \(error.localizedDescription)")
                    }
                } else {
                    self.view.makeToast(data.Message)
                }
            }
        } else {
            self.view.makeToast("Check your network connection")
        }
    }
    
    func SetUpData(data : ModelUserData) {
        
        lblUserName.text = data.fullName
        lblUserInfo.text = data.nickName
        if data.isBusinessProfileRegistered {
            viewBussines.isHidden = false
        } else {
            viewBussines.isHidden = true
        }
        
        if (data.socialMediaLinks.filter({$0.platform.contains("Instagram")}).first != nil) {
            btnInsta.isHidden = false
        } else {
            btnInsta.isHidden = true
        }
        
        if (data.socialMediaLinks.filter({$0.platform.contains("Facebook")}).first != nil) {
            btnFacebook.isHidden = false
        } else {
            btnFacebook.isHidden = true
        }

        if (data.socialMediaLinks.filter({$0.platform.contains("Twitter")}).first != nil) {
            btnTwitter.isHidden = false
        } else {
            btnTwitter.isHidden = true
        }

        if (data.socialMediaLinks.filter({$0.platform.contains("Pintrest")}).first != nil) {
            btnPintrest.isHidden = false
        } else {
            btnPintrest.isHidden = true
        }

        if (data.socialMediaLinks.filter({$0.platform.contains("Linkedin")}).first != nil) {
            btnLinkedin.isHidden = false
        } else {
            btnLinkedin.isHidden = true
        }

        if (data.socialMediaLinks.filter({$0.platform.contains("Youtube")}).first != nil) {
            btnYoutube.isHidden = false
        } else {
            btnYoutube.isHidden = true
        }

    }

    //MARK: - IBActions
    @IBAction func btnBackPressed(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnEditProfilePressed(_ sender : UIButton) {
        self.gotoPersonalProfileVC(isFromUpdate: true)
    }
    
    @IBAction func btnBussinesPressed(_ sender : UIButton) {
        self.gotoProductListVC()
    }
    
    @IBAction func btnInstaPressed(_ sender : UIButton) {
    }
    
    @IBAction func btnLinkedInPressed(_ sender : UIButton) {
    }
    
    @IBAction func btnTwitterPressed(_ sender : UIButton) {
    }
    
    @IBAction func btnFaceBookPressed(_ sender : UIButton) {
    }
    
    @IBAction func btnYoutubePressed(_ sender : UIButton) {
    }

    @IBAction func btnPrintrestPressed(_ sender : UIButton) {
    }

    
    @IBAction func btnUserProfilePressed(_ sender : UIButton) {
        self.OpenGallerySheet()
    }
    
}

extension UserProfileVC: JXSegmentedViewDelegate {
    
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        
    }
}

extension UserProfileVC: JXSegmentedListContainerViewDataSource {
    
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        if let titleDataSource = viewSegmentHeader.dataSource as? JXSegmentedBaseDataSource {
            return titleDataSource.dataSource.count
        }
        return 0
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        
        switch index {
        case 0 :
            
            return userPersonalInfoVC
        case 1 :
            return userBussinesInfoVC
        case 2:
            return reelsVC
        default:
            return userPersonalInfoVC
        }
    }
}

extension UserProfileVC : UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    func OpenGallerySheet() {
        
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = btnProfileEdit
            alert.popoverPresentationController?.sourceRect = btnProfileEdit.bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallary() {
        
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let chosenImage = info[.originalImage] as? UIImage{
            imgProfile.image = chosenImage
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }

}

