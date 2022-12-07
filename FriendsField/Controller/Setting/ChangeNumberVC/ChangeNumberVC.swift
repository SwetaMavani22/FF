//
//  ChangeNumberVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 21/05/22.
//

import UIKit

class ChangeNumberVC: UIViewController {
    
    //MARK: - Variables
    @IBOutlet var viewNavigation : UIView!
    @IBOutlet var viewPopup: UIView!

    @IBOutlet var txtOldNumber : UITextField!
    @IBOutlet var txtNewNumber : UITextField!

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
    
    @IBAction func btnChangeNumberPressed(_ sender : UIButton) {
        AddSubViewtoParentView(parentview: self.view, subview: self.viewPopup)
    }

    @IBAction func btnShadowPressed(_ sender : UIButton) {
        
        self.viewPopup.removeFromSuperview()
    }

    @IBAction func btnNoPressed(_ sender : UIButton) {
        
        self.viewPopup.removeFromSuperview()
    }

    @IBAction func btnYesPressed(_ sender : UIButton) {
        
        self.viewPopup.removeFromSuperview()
    }

    @IBAction func btnclosePressed(_ sender : UIButton) {
        
        self.viewPopup.removeFromSuperview()
    }

}

extension ChangeNumberVC : UITextFieldDelegate {
    
}
