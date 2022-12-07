//
//  SelectPackageVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 21/06/22.
//

import UIKit

class SelectPackageVC: UIViewController {
    
    @IBOutlet var viewNavigation : UIView!
    
    @IBOutlet var imgPlan1 : UIImageView!
    @IBOutlet var imgPlan2 : UIImageView!
    @IBOutlet var imgPlan3 : UIImageView!
    
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
        
        imgPlan1.image = UIImage(named: "ic_Plan_Deselect")
        imgPlan2.image = UIImage(named: "ic_Plan_Deselect")
        imgPlan3.image = UIImage(named: "ic_Plan_Deselect")
    }

    //MARK: - IBActions
    @IBAction func btnBackPressed(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnPlan1Pressed(_ sender : UIButton) {
        if imgPlan1.image == UIImage(named: "ic_Plan_Deselect") {
            
        } else {
            imgPlan1.image = UIImage(named: "ic_Plan_Deselect")
        }
    }

    @IBAction func btnPlan2Pressed(_ sender : UIButton) {
        if imgPlan2.image == UIImage(named: "ic_Plan_Deselect") {
            
        } else {
            imgPlan2.image = UIImage(named: "ic_Plan_Deselect")
        }
    }

    @IBAction func btnPlan3Pressed(_ sender : UIButton) {
        if imgPlan3.image == UIImage(named: "ic_Plan_Deselect") {
            
        } else {
            imgPlan3.image = UIImage(named: "ic_Plan_Deselect")
        }
    }

    @IBAction func btnContinuePressed(_ sender : UIButton) {
    }
}
