//
//  OTPverificationVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 16/05/22.
//

import UIKit
import OTPFieldView
import Alamofire

class OTPverificationVC: UIViewController {
    
    //MARK: - Variables
    @IBOutlet var viewOTP : OTPFieldView!
    
    @IBOutlet var lblTime : UILabel!
    
    var authToken = ""
    var strOtp = ""
    var PhoneNumber = ""
    var timer: Timer?
    var totalTime = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SetupUI()
    }
    
    //MARK: - Private Method
    func SetupUI() {
        
        self.startOtpTimer()
        self.setupOtpView()
    }
    
    func startOtpTimer() {
        self.lblTime.text = "00:30"
        self.totalTime = 30
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        self.lblTime.text = self.timeFormatted(self.totalTime)
        if totalTime != 0 {
            totalTime -= 1
        } else {
            if let timer = self.timer {
                timer.invalidate()
                self.timer = nil
            }
        }
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func setupOtpView(){
        self.viewOTP.fieldsCount = 4
        self.viewOTP.fieldBorderWidth = 1
        self.viewOTP.defaultBackgroundColor = UIColor.init(hexString: colors.ThemeGray)
        self.viewOTP.defaultBorderColor = UIColor.init(hexString: colors.ThemeGray)
        self.viewOTP.filledBorderColor = UIColor.init(hexString: colors.ThemeSky)
        self.viewOTP.filledBackgroundColor = UIColor.init(hexString: colors.ThemeGray)
        self.viewOTP.cursorColor = UIColor.black
        self.viewOTP.displayType = .square
        self.viewOTP.fieldSize = 50
        self.viewOTP.separatorSpace = 20
        self.viewOTP.shouldAllowIntermediateEditing = false
        self.viewOTP.otpInputType = .numeric
        self.viewOTP.delegate = self
        self.viewOTP.initializeUI()
    }
    
    func VerifyOTP() {
        
        if (isConnectedToNetwork()) {
            let headers: HTTPHeaders = ["authorization" : self.authToken, "Content-Type" : "application/json"]
            let params:[String:Any] = ["otp": strOtp]
            APIManager.APIPostCalling(API_URL.Url_VerifyOtp, headers : headers, params: params) { (response) in
                print(response)
                let data = ModelVerifyOTP.init(dic: response as? [String:Any] ?? [:])
                if data.Status == API_URL.StatusCode {
                    GlobalUserToken = data.Data.token
                    do {
                        let encodedData = try NSKeyedArchiver.archivedData(withRootObject: GlobalUserToken, requiringSecureCoding: false)
                        Defualtss.set(encodedData, forKey: UDKey.kUserToken)
                        Defualtss.synchronize()
                        self.timer?.invalidate()
                        self.timer = nil
                        self.gotoHomeVC()
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
    
    //MARK: - IBActions
    @IBAction func btnResendCodePressed(_ sender : UIButton) {
        
        if timer == nil {
            self.timer?.invalidate()
            self.startOtpTimer()
            
            if (isConnectedToNetwork()) {
                let params:[String:Any] = ["contactNo": PhoneNumber]
                APIManager.APIPostCalling(API_URL.Url_SendOtp, params: params) { (response) in
                    //print(response)
                    let data = ModelSendOTP.init(dic: response as? [String:Any] ?? [:])
                    if data.Status == API_URL.StatusCode {
                        self.authToken = data.Data.token
                    } else {
                        self.view.makeToast(data.Message)
                    }
                }
            } else {
                self.view.makeToast("Check your network connection")
            }
        } else {
            self.view.makeToast("Please Wait..")
        }
        
    }
    
    @IBAction func btnVerifyPressed(_ sender : UIButton) {
        
        self.timer?.invalidate()
        self.startOtpTimer()
        self.timer = nil
        
        if strOtp != "" {
            VerifyOTP()
        } else {
            self.view.makeToast("Please Enter OTP")
        }
    }
    
    @IBAction func btnBackPressed(_ sender : UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension OTPverificationVC: OTPFieldViewDelegate {
    
    func hasEnteredAllOTP(hasEnteredAll hasEntered: Bool) -> Bool {
        print("Has entered all OTP? \(hasEntered)")
        return false
    }
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otp otpString: String) {
        print("OTPString: \(otpString)")
        strOtp = otpString
    }
}
