//
//  EditGroupDetailsVC.swift
//  FriendsField
//
//  Created by iMac on 22/08/22.
//

import UIKit

class EditGroupDetailsVC: UIViewController {
    
    @IBOutlet var viewNavigation : UIView!
    
    @IBOutlet var txtGroupName : UITextField!
    @IBOutlet var txtGroupDesc : UITextView!

    //MARK: - Variables
    
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

    //MARK: - IBActions
    @IBAction func btnBackPressed(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSavePressed(_ sender : UIButton) {
    }

    @IBAction func btnChangeImagePressed(_ sender : UIButton) {
    }

}

extension EditGroupDetailsVC : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Description" {
            textView.text = ""
        }
        
        if textView == self.txtGroupDesc {
            self.txtGroupDesc.becomeFirstResponder()
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Description"
        }
    }
}

extension EditGroupDetailsVC : UITextFieldDelegate {
}
