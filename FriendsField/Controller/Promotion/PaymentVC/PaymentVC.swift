//
//  PaymentVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 20/06/22.
//

import UIKit

class PaymentVC: UIViewController {
    
    @IBOutlet var lblAount : UILabel!
    
    @IBOutlet var btnPay : UIButton!
    
    @IBOutlet var txtCardHolderName : UITextField!
    @IBOutlet var txtCardHolderNumber : UITextField!
    @IBOutlet var txtCardHolderExpiryDate : UITextField!
    @IBOutlet var txtCardHolderCVV : UITextField!

    //MARK: - Variables
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SetupUI()
    }

    //MARK: - Private Method
    func SetupUI() {
        
    }

    //MARK: - IBActions
    @IBAction func btnBackPressed(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnPayPressed(_ sender : UIButton) {
        self.gotoPaymentSuccesVC()
    }

}

extension PaymentVC : UITextFieldDelegate {
    
    
}
