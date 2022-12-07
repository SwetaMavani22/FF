//
//  StartPromotionVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 18/06/22.
//

import UIKit

class StartPromotionVC: UIViewController {
    
    //MARK: - Variables
    @IBOutlet var viewNavigation : UIView!
    @IBOutlet var viewExistingUser : UIView!
    @IBOutlet var viewAppUser : UIView!
    @IBOutlet var viewUploadExe : UIView!
    @IBOutlet var viewRemoveExe : UIView!

    @IBOutlet var lblSelectedUserCount : UILabel!
    @IBOutlet var lblSelectPackage : UILabel!

    @IBOutlet var imgExistingUser : UIImageView!
    @IBOutlet var imgAppUser : UIImageView!
    
    @IBOutlet var txtSelectedNumberOfUsers : UITextField!
    @IBOutlet var txtAddress : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SetupUI()
    }

    override func viewDidLayoutSubviews() {
        self.viewNavigation.addBottomShadow()
    }

    //MARK: - Private Method
    func SetupUI() {
        
        imgExistingUser.image = UIImage(named: "ic_radio")
        imgAppUser.image = UIImage(named: "ic_radio")
        viewExistingUser.isHidden = true
        viewAppUser.isHidden = true
    }
    
    func PromotionTypeSelect(selectedImage : UIImageView) {
        
        imgExistingUser.image = UIImage(named: "ic_radio")
        imgAppUser.image = UIImage(named: "ic_radio")

        selectedImage.image = UIImage(named: "ic_SelectedPromotion")
        
        if selectedImage == imgExistingUser {
            viewExistingUser.isHidden = false
        } else {
            viewExistingUser.isHidden = true
        }
        
        if selectedImage == imgAppUser {
            viewAppUser.isHidden = false
        } else {
            viewAppUser.isHidden = true
        }

    }
    
    //MARK: - IBActions
    @IBAction func btnBackPressed(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnExistingUserPressed(_ sender : UIButton) {
        PromotionTypeSelect(selectedImage: imgExistingUser)
    }

    @IBAction func btnAppUserPressed(_ sender : UIButton) {
        PromotionTypeSelect(selectedImage: imgAppUser)
    }

    @IBAction func btnContinuePressed(_ sender : UIButton) {
        self.gotoPromotionDataAndTimeVC()
    }

    @IBAction func btnSelectUserPressed(_ sender : UIButton) {
        self.gotoSelectUserVC()
    }

    @IBAction func btnSelectPackagePressed(_ sender : UIButton) {
        self.gotoSelectPackageVC()
    }

    @IBAction func btnSelectNumberofUsersPressed(_ sender : UIButton) {
    }

    @IBAction func btnSelectAddressPressed(_ sender : UIButton) {
    }

}

extension StartPromotionVC : UITextFieldDelegate {
    
}
