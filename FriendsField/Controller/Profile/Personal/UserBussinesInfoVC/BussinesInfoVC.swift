//
//  UserBussinesInfoVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 18/05/22.
//

import UIKit
import JXSegmentedView
import Alamofire

class BussinesInfoVC: UIViewController {
    
    //MARK: - Variables
    @IBOutlet weak var lblBussinesName: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblSubCategory: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblIntrestedCat: UILabel!
    @IBOutlet weak var lblIntrestedSubCat: UILabel!
    
    @IBOutlet weak var imgBussinesLogo: UIImageView!
        
    @IBOutlet var viewNoData : UIView!
    
    @IBOutlet var btnProfileEdit : UIButton!
    
    var userData = ModelUserData()
    
    var isFrom = ""
    var imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SetupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        self.FetchUserBussinesData()
    }
    
    //MARK: - Private Method
    func SetupUI() {
        self.imagePicker.delegate = self
    }
    
    func FetchUserBussinesData() {
        
        if (isConnectedToNetwork()) {
            
            let headers: HTTPHeaders = ["authorization" : "bearer \(GlobalUserToken.token)", "Content-Type" : "application/json"]
            
            APIManager.APIGetCalling(API_URL.Url_FetchBussinesProfile, headers: headers) { (response) in
                print(response)
                let data = ModelBussinesProfile.init(dic: response as? [String:Any] ?? [:])
                
                if data.Status == API_URL.StatusCode {
                    self.viewNoData.isHidden = true
                    self.lblBussinesName.text = data.Data.name
                    self.lblCategory.text = data.Data.category
                    self.lblSubCategory.text = data.Data.subCategory
                    self.lblDesc.text = data.Data.Description
                    self.lblIntrestedCat.text = data.Data.interestedCategory
                    self.lblIntrestedSubCat.text = data.Data.interestedSubCategory
                    let lat = Double(data.Data.latitude)
                    let long = Double(data.Data.longitude)
                    GetAddress(Lat: lat ?? 0.0, Long: long ?? 0.0, completion: { (ADDRESS) in
                        self.lblLocation.text = ADDRESS
                    })
                } else {
                    self.viewNoData.isHidden = false
                }
            }
        } else {
            self.view.makeToast("Check your network connection")
        }
    }
    
    //MARK: - IBActions
    @IBAction func btnBackPressed(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnClearChatPressed(_ sender : UIButton) {
    }
    
    @IBAction func btnBlockPressed(_ sender : UIButton) {
    }
    
    @IBAction func btnReportPressed(_ sender : UIButton) {
    }
    
    @IBAction func btnViewBrouchrePressed(_ sender : UIButton) {
    }
    
    @IBAction func switchVideoCallPressed(_ sender : UISwitch) {
    }
    
    @IBAction func switchVoiceCallPressed(_ sender : UISwitch) {
    }
    
    @IBAction func btnCreateProfilePressed(_ sender : UIButton) {
        self.gotoBussinessProfileVC(isFromUpdate: false)
    }
    
    @IBAction func btnEditBusinessLogoPressed(_ sender : UIButton) {
        self.OpenGallerySheet()
    }

    
}

extension BussinesInfoVC: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}

extension BussinesInfoVC : UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
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
            imgBussinesLogo.image = chosenImage
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }

}
