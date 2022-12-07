//
//  ApplyCouponVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 20/06/22.
//

import UIKit

class ApplyCouponVC: UIViewController {
    
    @IBOutlet var viewNavigation : UIView!
    
    @IBOutlet var tblCouponsData : UITableView!

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
        
    }

    //MARK: - IBActions
    @IBAction func btnBackPressed(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ApplyCouponVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = indexPath.row + 1
        if (index % 4 == 0 && indexPath.row != 0) {
            let cellBanner = tblCouponsData.dequeueReusableCell(withIdentifier: "cellAds", for: indexPath) as! cellAds

            return cellBanner
        } else {
            if let cell = tblCouponsData.dequeueReusableCell(withIdentifier: "cellCoupons") as? cellCoupons {
                
                cell.btnApply.addTarget(self, action: #selector(btnApplyPressed(sender:)), for: .touchUpInside)
                cell.btnApply.tag = indexPath.row
                
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    @objc func btnApplyPressed(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

}
