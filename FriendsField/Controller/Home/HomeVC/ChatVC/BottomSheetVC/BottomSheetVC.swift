//
//  BottomSheetVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 15/06/22.
//

import UIKit

class BottomSheetVC: UIViewController {
    
    //MARK: - Variables
    @IBOutlet var imgContact : UIImageView!
    @IBOutlet var imgApp : UIImageView!
    @IBOutlet var imgReceiver : UIImageView!
    @IBOutlet var imgSender : UIImageView!
    
    var arrSelectedFilter = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SetupUI()
    }

    //MARK: - Private Method
    func SetupUI() {
        
        self.imgContact.image = UIImage(named: "ic_radio")
        self.imgApp.image = UIImage(named: "ic_radio")
        self.imgReceiver.image = UIImage(named: "ic_radio")
        self.imgSender.image = UIImage(named: "ic_radio")
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

    @IBAction func btnReceiverFriendPressed(_ sender : UIButton) {
        
        if imgReceiver.image == UIImage(named: "ic_radio") {
            self.imgReceiver.image = UIImage(named: "ic_Show")
        } else {
            self.imgReceiver.image = UIImage(named: "ic_radio")
        }
    }

    @IBAction func btnSenderFriendPressed(_ sender : UIButton) {
        
        if imgSender.image == UIImage(named: "ic_radio") {
            self.imgSender.image = UIImage(named: "ic_Show")
        } else {
            self.imgSender.image = UIImage(named: "ic_radio")
        }
    }

}
