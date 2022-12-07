//
//  PromotionBillVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 20/06/22.
//

import UIKit

class PromotionBillVC: UIViewController {
    
    @IBOutlet var viewNavigation : UIView!
    @IBOutlet var viewApplyCoupon : UIView!
    @IBOutlet var viewRemoveCoupon : UIView!
    @IBOutlet var viewDiscountView : UIView!
    
    @IBOutlet var lblPromotionTitle : UILabel!
    @IBOutlet var lblPromotionDesc : UILabel!
    @IBOutlet var lblDateAndTime : UILabel!
    @IBOutlet var lblNotification : UILabel!
    @IBOutlet var lblEmail : UILabel!
    @IBOutlet var lblSMS : UILabel!
    @IBOutlet var lblDiscountCoupon : UILabel!
    @IBOutlet var lblDiscountAmount : UILabel!
    @IBOutlet var lblSubTotalAmount : UILabel!
    @IBOutlet var lblTotalAmount : UILabel!
    @IBOutlet var lblNotificationAmount : UILabel!
    @IBOutlet var lblEmailAmount : UILabel!
    @IBOutlet var lblSMSAmount : UILabel!

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
        viewRemoveCoupon.isHidden = true
    }

    //MARK: - IBActions
    @IBAction func btnBackPressed(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnApplyCouponPressed(_ sender : UIButton) {
        self.gotoApplyCouponVC()
    }

    @IBAction func btnRemoveCouponPressed(_ sender : UIButton) {
    }

    @IBAction func btnPayNowPressed(_ sender : UIButton) {
        self.gotoPaymentVC()
    }

}
