//
//  PromotionDataAndTimeVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 18/06/22.
//

import UIKit

class PromotionDataAndTimeVC: UIViewController {
    
    @IBOutlet var viewNavigation : UIView!
    
    @IBOutlet var txtDate : UITextField!
    @IBOutlet var txtTime : UITextField!
    
    @IBOutlet var imgNotification : UIImageView!
    @IBOutlet var imgEmail : UIImageView!
    @IBOutlet var imgSMS : UIImageView!
    
    //MARK: - Variables
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SetupUI()
    }
    
    override func viewDidLayoutSubviews() {
        self.viewNavigation.addBottomShadow()
    }
    
    
    //MARK: - Private Method
    func SetupUI() {
        
        imgNotification.image = UIImage(named: "ic_Box")
        imgEmail.image = UIImage(named: "ic_Box")
        imgSMS.image = UIImage(named: "ic_Box")
    }
    
    func SelectCategory(selectedImageView : UIImageView) {
        
        if selectedImageView == imgNotification {
            if imgNotification.image == UIImage(named: "ic_Box") {
                imgNotification.image = UIImage(named: "ic_CheckBox")
            } else {
                imgNotification.image = UIImage(named: "ic_Box")
            }
        }
        
        if selectedImageView == imgEmail {
            if imgEmail.image == UIImage(named: "ic_Box") {
                imgEmail.image = UIImage(named: "ic_CheckBox")
            } else {
                imgEmail.image = UIImage(named: "ic_Box")
            }
        }
        
        if selectedImageView == imgSMS {
            
            if imgSMS.image == UIImage(named: "ic_Box") {
                imgSMS.image = UIImage(named: "ic_CheckBox")
            } else {
                imgSMS.image = UIImage(named: "ic_Box")
            }
        }
    }
    
    //MARK: - IBActions
    @IBAction func btnBackPressed(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNotificationPressed(_ sender : UIButton) {
        SelectCategory(selectedImageView: imgNotification)
    }
    
    @IBAction func btnMailPressed(_ sender : UIButton) {
        SelectCategory(selectedImageView: imgEmail)
    }
    
    @IBAction func btnSMSPressed(_ sender : UIButton) {
        SelectCategory(selectedImageView: imgSMS)
    }
    
    @objc func selectedDate(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        txtDate.text = dateFormatter.string(from: sender.date)
    }
    
    @objc func selectedTime(sender: UIDatePicker) {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:SS"
        txtTime.text = timeFormatter.string(from: sender.date)
    }
    
    @IBAction func btnContinuePressed(_ sender : UIButton) {
        self.gotoPromotionBillVC()
    }

}

extension PromotionDataAndTimeVC : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {    //delegate method
        if textField == txtDate {
            self.dismiss(animated: true, completion: nil)
            datePicker.datePickerMode = UIDatePicker.Mode.date
            if #available(iOS 13.4, *) {
                datePicker.preferredDatePickerStyle = .wheels
            }
            textField.inputView = datePicker
            datePicker.addTarget(self, action: #selector(self.selectedDate(sender:)), for: UIControl.Event.valueChanged)
        } else if textField == txtTime {
            self.dismiss(animated: true, completion: nil)
            datePicker.datePickerMode = UIDatePicker.Mode.time
            if #available(iOS 13.4, *) {
                datePicker.preferredDatePickerStyle = .wheels
            }
            textField.inputView = datePicker
            datePicker.addTarget(self, action: #selector(self.selectedTime(sender:)), for: UIControl.Event.valueChanged)
        }
        
    }
    
}
