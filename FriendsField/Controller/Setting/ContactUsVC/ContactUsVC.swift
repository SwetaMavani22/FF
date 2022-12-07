//
//  ContactUsVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 21/05/22.
//

import UIKit
import Alamofire

class ContactUsVC: UIViewController {
    
    //MARK: - Variables
    @IBOutlet var viewNavigation : UIView!

    @IBOutlet var txtName : UITextField!
    @IBOutlet var txtPhoneNumber : UITextField!
    @IBOutlet var txtEmail : UITextField!
    
    @IBOutlet var txtDesc : UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SetupUI()
    }

    override func viewDidLayoutSubviews() {
        self.viewNavigation.addBottomShadow()
    }

    //MARK: - Private Method
    func SetupUI() {
        
    }
    
    func ContactUsData() {
        
        if (isConnectedToNetwork()) {
            
            let headers: HTTPHeaders = ["authorization" : "bearer \(GlobalUserToken.token)", "Content-Type" : "application/json"]
            let params:[String:Any] = ["fullName": txtName.text ?? "" , "contactNo" : txtPhoneNumber.text ?? "", "emailId" : txtEmail.text ?? "", "issue" : txtDesc.text ?? ""]
            APIManager.APIPostCalling(API_URL.Url_ContactUS, headers : headers , params: params) { (response) in
                //print(response)
                let data = ModelContactUS.init(dic: response as? [String:Any] ?? [:])
                if data.Status == API_URL.StatusCode {
                    self.view.makeToast(data.Message)
                    self.txtName.text = ""
                    self.txtDesc.text = ""
                    self.txtEmail.text = ""
                    self.txtPhoneNumber.text = ""
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
    
    @IBAction func btnSendPressed(_ sender : UIButton) {
        ContactUsData()
    }

}

extension ContactUsVC : UITextFieldDelegate {
    
}

extension ContactUsVC : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Describe Your Issue" {
            textView.text = ""
        }
        
        if textView == self.txtDesc {
            self.txtDesc.becomeFirstResponder()
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Describe Your Issue"
        }
    }

}
