//
//  RunningVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 17/06/22.
//

import UIKit
import JXSegmentedView

class RunningVC: UIViewController {
    
    //MARK: - Variables
    @IBOutlet var tblRunningData : UITableView!
    

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
}

extension RunningVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = indexPath.row + 1
        if (index % 2 == 0 && indexPath.row != 0) {
            let cellBanner = tblRunningData.dequeueReusableCell(withIdentifier: "cellAds", for: indexPath) as! cellAds

            return cellBanner
        } else {
            if let cell = tblRunningData.dequeueReusableCell(withIdentifier: "cellRunningPromotion") as? cellRunningPromotion {
                
                cell.btnPromotion.addTarget(self, action: #selector(btnPromotionPressed(sender:)), for: .touchUpInside)
                cell.btnPromotion.tag = indexPath.row
                
                cell.btnEditNotification.addTarget(self, action: #selector(btnEditNotificationPressed(sender:)), for: .touchUpInside)
                cell.btnEditNotification.tag = indexPath.row
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
    
    @objc func btnPromotionPressed(sender: UIButton){
        self.gotoPromotionPlanVC()
    }

    @objc func btnEditNotificationPressed(sender: UIButton){
        self.gotoCreateNotificationVC(isUpdate: true)
    }

}

extension RunningVC: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}
