//
//  WelcomeVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 16/05/22.
//

import UIKit
import FlagPhoneNumber

class OtpsendVC: UIViewController {
    
    //MARK: - Variables
    @IBOutlet weak var txtPhoneNumber : FPNTextField!
    
    var CountryCode = "";
    
    var IsValid = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SetupUI()
    }
    
    //MARK: - Private Method
    func SetupUI() {
        
        CountryCode = "91"
        txtPhoneNumber.setFlag(key: .IN)
        txtPhoneNumber.displayMode = .picker
        txtPhoneNumber.delegate = self
    }
    
    func loginData() {
        
        if (isConnectedToNetwork()) {
            print(CountryCode)
            let phoneNumber = txtPhoneNumber.text?.filter { !$0.isWhitespace }
            let params:[String:Any] = ["contactNo": phoneNumber ?? "" , "countryCode" : CountryCode]
            APIManager.APIPostCalling(API_URL.Url_SendOtp, params: params) { (response) in
                //print(response)
                let data = ModelSendOTP.init(dic: response as? [String:Any] ?? [:])
                if data.Status == API_URL.StatusCode {
                    self.gotoOTPverificationVC(authToken: "bearer \(data.Data.token)", PhoneNumber: phoneNumber ?? "")
                } else {
                    self.view.makeToast(data.Message)
                }
            }
        } else {
            self.view.makeToast("Check your network connection")
        }
    }
    
    //MARK: - IBActions
    @IBAction func btnContinuePressed(_ sender : UIButton) {
        if txtPhoneNumber.text != "" && IsValid {
            loginData()
        } else {
            self.view.makeToast("Please Check Number")
        }
    }
}

extension OtpsendVC: FPNTextFieldDelegate {
    
    func fpnDisplayCountryList() {}
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        if isValid {
            IsValid = true
        } else {
            IsValid = false
        }
        print(
            isValid,
            textField.getFormattedPhoneNumber(format: .E164) ?? "E164: nil",
            textField.getFormattedPhoneNumber(format: .International) ?? "International: nil",
            textField.getFormattedPhoneNumber(format: .National) ?? "National: nil",
            textField.getFormattedPhoneNumber(format: .RFC3966) ?? "RFC3966: nil",
            textField.getRawPhoneNumber() ?? "Raw: nil"
        )
    }
    
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        print(name, dialCode, code)
        CountryCode = code
    }
}
