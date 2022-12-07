//
//  CallLogVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 18/05/22.
//

import UIKit
import JXSegmentedView

class CallLogVC: UIViewController {
    
    //MARK: - Variables
    @IBOutlet var tblCallData : UITableView!

    @IBOutlet var txtSearch : UITextField!
    
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
    
    @IBAction func btnSearchPressed(_ sender : UIButton) {
    }

}

extension CallLogVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tblCallData.dequeueReusableCell(withIdentifier: "cellCallLog") as? cellCallLog {
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension CallLogVC : UITextFieldDelegate {
    
}

extension CallLogVC: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}

