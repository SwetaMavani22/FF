//
//  OtherUserPersonalInfoVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 16/06/22.
//

import UIKit
import JXSegmentedView
import Alamofire
import CoreLocation

class OtherUserPersonalInfoVC: UIViewController {
    
    //MARK: - Variables
    @IBOutlet weak var lblPhoneNumber: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPopUpPhoneNumber: UILabel!
    @IBOutlet weak var lblPopupEmail: UILabel!
    @IBOutlet weak var lblPopupName: UILabel!
    @IBOutlet weak var lblPopupSocialMedia: UILabel!

    @IBOutlet weak var btnBlock: UIButton!
    @IBOutlet weak var btnReport: UIButton!
    
    @IBOutlet weak var viewOtherUser: UIStackView!
    
    @IBOutlet var viewPopup : UIView!
    
    var ParentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SetupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.FetchUserPersonalData()
    }
    
    //MARK: - Private Method
    func SetupUI() {
        
    }
    
    func FetchUserPersonalData() {
        
        if (isConnectedToNetwork()) {
            
            let headers: HTTPHeaders = ["authorization" : "bearer \(GlobalUserToken.token)", "Content-Type" : "application/json"]
            
            APIManager.APIGetCalling(API_URL.Url_FetchPersonalProfile, headers: headers) { (response) in
                //print(response)
                let data = ModelPersonalProfile.init(dic: response as? [String:Any] ?? [:])
                if data.Status == API_URL.StatusCode {
                    GlobalUserData = data.Data
                    do {
                        let encodedData = try NSKeyedArchiver.archivedData(withRootObject: GlobalUserData, requiringSecureCoding: false)
                        Defualtss.set(encodedData, forKey: UDKey.kUserData)
                        self.SetUpData(data: data.Data)
                    } catch {
                        print("Something went wrong.")
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
        
        lblPhoneNumber.text = data.contactNo
        lblEmail.text = data.emailId
        lblPopupName.text = data.fullName
        lblPopupEmail.text = data.emailId
        lblPopUpPhoneNumber.text = data.contactNo
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
    
    @IBAction func btnAuthorizedPressed(_ sender : UIButton) {
        AddSubViewtoParentView(parentview: ParentView, subview: self.viewPopup)
    }

    @IBAction func btnClosePressed(_ sender : UIButton) {
        self.viewPopup.removeFromSuperview()
    }

    @IBAction func btnShadowPressed(_ sender : UIButton) {
        self.viewPopup.removeFromSuperview()
    }

    @IBAction func switchVideoCallPressed(_ sender : UISwitch) {
    }
    
    @IBAction func switchVoiceCallPressed(_ sender : UISwitch) {
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

extension OtherUserPersonalInfoVC: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}

