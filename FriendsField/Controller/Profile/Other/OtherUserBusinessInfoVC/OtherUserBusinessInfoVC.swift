//
//  OtherUserBusinessInfoVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 16/06/22.
//

import UIKit
import JXSegmentedView
import Alamofire

class OtherUserBusinessInfoVC: UIViewController {
    
    //MARK: - Variables
    @IBOutlet weak var lblBussinesName: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblSubCategory: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblIntrestedCat: UILabel!
    @IBOutlet weak var lblIntrestedSubCat: UILabel!
    @IBOutlet weak var lblPopUpPhoneNumber: UILabel!
    @IBOutlet weak var lblPopupEmail: UILabel!
    @IBOutlet weak var lblPopupName: UILabel!
    @IBOutlet weak var lblPopupSocialMedia: UILabel!
    
    @IBOutlet weak var imgBussinesLogo: UIImageView!
    
    @IBOutlet weak var btnBlock: UIButton!
    @IBOutlet weak var btnReport: UIButton!
    
    @IBOutlet weak var viewOtherUser: UIStackView!
    
    @IBOutlet var viewNoData : UIView!
    @IBOutlet var viewPopup : UIView!
    
    var isFrom = ""
    var ParentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SetupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                
        if GlobalUserData.isBusinessProfileRegistered {
            viewNoData.isHidden = true
        } else {
            viewNoData.isHidden = false
        }
        
        self.FetchUserBussinesData()
    }
    
    //MARK: - Private Method
    func SetupUI() {
        
    }
    
    func FetchUserBussinesData() {
        
        if (isConnectedToNetwork()) {
            
            let headers: HTTPHeaders = ["authorization" : "bearer \(GlobalUserToken.token)", "Content-Type" : "application/json"]
            
            APIManager.APIGetCalling(API_URL.Url_FetchBussinesProfile, headers: headers) { (response) in
                print(response)
                let data = ModelBussinesProfile.init(dic: response as? [String:Any] ?? [:])
                
                if data.Status == API_URL.StatusCode {
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
                    self.view.makeToast(data.Message)
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
    
    @IBAction func switchVideoCallPressed(_ sender : UISwitch) {
    }
    
    @IBAction func switchVoiceCallPressed(_ sender : UISwitch) {
    }
    
    @IBAction func btnCreateProfilePressed(_ sender : UIButton) {
        self.gotoBussinessProfileVC(isFromUpdate: false)
    }
    
    @IBAction func btnAuthorizedPressed(_ sender : UIButton) {
        AddSubViewtoParentView(parentview: ParentView, subview: self.viewPopup)
    }

    @IBAction func btnClosePressed(_ sender : UIButton) {
        self.viewPopup.removeFromSuperview()
    }

    @IBAction func btnShadowPressed(_ sender : UIButton) {
        self.viewPopup.removeFromSuperview()
    }
    
    @IBAction func btnViewBroucherPressed(_ sender : UIButton) {
    }

    @IBAction func switchFullNamePressed(_ sender : UISwitch) {
    }

    @IBAction func switchPhoneNumberPressed(_ sender : UISwitch) {
    }

    @IBAction func switchEmailPressed(_ sender : UISwitch) {
    }

    @IBAction func switchSocialMediaPressed(_ sender : UISwitch) {
    }

}

extension OtherUserBusinessInfoVC: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}

