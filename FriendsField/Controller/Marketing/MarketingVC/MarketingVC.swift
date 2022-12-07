//
//  MarketingVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 20/05/22.
//

import UIKit

class MarketingVC: UIViewController {
    
    //MARK: - Variables
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
    
    @IBAction func btnBuyPlanPressed(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}
