//
//  HistoryVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 17/06/22.
//

import UIKit
import JXSegmentedView

class HistoryVC: UIViewController {
    
    //MARK: - Variables
    @IBOutlet var tblHistoryData : UITableView!
    

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

extension HistoryVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = indexPath.row + 1
        if (index % 2 == 0 && indexPath.row != 0) {
            let cellBanner = tblHistoryData.dequeueReusableCell(withIdentifier: "cellAds", for: indexPath) as! cellAds

            return cellBanner
        } else {
            if let cell = tblHistoryData.dequeueReusableCell(withIdentifier: "cellHistoryPromotion") as? cellHistoryPromotion {
                
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.gotoHistoryDetailsVC()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}


extension HistoryVC: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}
