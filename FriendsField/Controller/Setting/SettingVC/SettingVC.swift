//
//  SettingVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 20/05/22.
//

import UIKit

class SettingVC: UIViewController {
    
    //MARK: - Variables
    @IBOutlet var viewNavigation : UIView!
    @IBOutlet var viewBackupPopup : UIView!
    @IBOutlet var viewUploadExcel : UIView!
    @IBOutlet var viewUploadFile : UIView!
    @IBOutlet var viewSelecteExcelFile : UIView!
    
    @IBOutlet var lblLocal : UILabel!
    @IBOutlet var lblGoogleDrive : UILabel!
    @IBOutlet var lblGoogleAccount : UILabel!

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
    
    func SignOut() {
        
        Defualtss.removeObject(forKey: UDKey.kUserData)
        Defualtss.removeObject(forKey: UDKey.kUserToken)
        Defualtss.removeObject(forKey: UDKey.kUserBussinesData)
        Defualtss.synchronize()
        
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "OtpsendVC") as? OtpsendVC {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //MARK: - IBActions
    @IBAction func btnBackPressed(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnClearChatPressed(_ sender : UIButton) {
    }

    @IBAction func btnBlockContactPressed(_ sender : UIButton) {
        self.gotoBlockContactVC()
    }

    @IBAction func btnChangeNumberPressed(_ sender : UIButton) {
        self.gotoChangeNumberVC()
    }

    @IBAction func btnContactUsPressed(_ sender : UIButton) {
        self.gotoContactUsVC()
    }

    @IBAction func btnHelpPressed(_ sender : UIButton) {
        self.gotoHelpVC()
    }

    @IBAction func btnSignoutPressed(_ sender : UIButton) {
        self.SignOut()
    }
    
    @IBAction func btnChatBackupPressed(_ sender : UIButton) {
        AddSubViewtoParentView(parentview: self.view, subview: self.viewBackupPopup)
    }

    @IBAction func btnConversactionPressed(_ sender : UIButton) {
    }

    @IBAction func btnUploadExcelPressed(_ sender : UIButton) {
        AddSubViewtoParentView(parentview: self.view, subview: self.viewUploadFile)
    }

    @IBAction func switchNotificationPressed(_ sender : UISwitch) {
    }
    
    @IBAction func btnBackupClosePressed(_ sender : UIButton) {
        self.viewBackupPopup.removeFromSuperview()
    }

    @IBAction func btnBackupPressed(_ sender : UIButton) {
    }

    @IBAction func btnUploadClosePressed(_ sender : UIButton) {
        self.viewUploadFile.removeFromSuperview()
    }

    @IBAction func btnUploadFilePressed(_ sender : UIButton) {
    }

}
