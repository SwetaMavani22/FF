//
//  PaymentSuccesVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 20/06/22.
//

import UIKit

class PaymentSuccesVC: UIViewController {
    
    @IBOutlet var lblAmount : UILabel!

    //MARK: - Variables
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SetupUI()
    }
    
    //MARK: - Private Method
    func SetupUI() {
        
    }

    //MARK: - IBActions
    @IBAction func btnOkPressed(_ sender : UIButton) {
        self.gotoBillDetailsVC()
    }
}
