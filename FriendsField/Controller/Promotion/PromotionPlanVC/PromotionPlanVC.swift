//
//  PromotionPlanVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 18/06/22.
//

import UIKit

class PromotionPlanVC: UIViewController {
    
    //MARK: - Variables
    @IBOutlet var lblPromotionDesc : UILabel!
    @IBOutlet var lblNotification : UILabel!
    @IBOutlet var lblEmail : UILabel!
    @IBOutlet var lblSMS : UILabel!
        
    @IBOutlet var viewNavigation : UIView!

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

    @IBAction func btnStartPromotionPressed(_ sender : UIButton) {
        self.gotoStartPromotionVC()
    }
}
