//
//  FilterUserPopUpVC.swift
//  FriendsField
//
//  Created by iMac on 23/08/22.
//

import UIKit

class FilterUserPopUpVC: UIViewController {
    
    //MARK: - Variables
    @IBOutlet var imgContact : UIImageView!
    @IBOutlet var imgApp : UIImageView!
    @IBOutlet var imgExcel : UIImageView!
    
    var arrSelectedFilter = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SetupUI()
    }

    //MARK: - Private Method
    func SetupUI() {
        
        self.imgContact.image = UIImage(named: "ic_radio")
        self.imgApp.image = UIImage(named: "ic_radio")
        self.imgExcel.image = UIImage(named: "ic_radio")
    }
    
    //MARK: - IBActions
    @IBAction func btnBackPressed(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCancelPressed(_ sender : UIButton) {
        self.dismiss(animated: true)
    }

    @IBAction func btnApplyPressed(_ sender : UIButton) {
        
    }

    @IBAction func btnContactFriendPressed(_ sender : UIButton) {
        
        if imgContact.image == UIImage(named: "ic_radio") {
            self.imgContact.image = UIImage(named: "ic_Show")
        } else {
            self.imgContact.image = UIImage(named: "ic_radio")
        }
    }

    @IBAction func btnAppFriendPressed(_ sender : UIButton) {
        
        if imgApp.image == UIImage(named: "ic_radio") {
            self.imgApp.image = UIImage(named: "ic_Show")
        } else {
            self.imgApp.image = UIImage(named: "ic_radio")
        }
    }

    @IBAction func btnExcelFriendPressed(_ sender : UIButton) {
        
        if imgExcel.image == UIImage(named: "ic_radio") {
            self.imgExcel.image = UIImage(named: "ic_Show")
        } else {
            self.imgExcel.image = UIImage(named: "ic_radio")
        }
    }


}
