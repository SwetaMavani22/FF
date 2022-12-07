//
//  ContactListVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 15/06/22.
//

import UIKit
import JXSegmentedView

class ContactListVC: UIViewController {
    
    //MARK: - Variables
    @IBOutlet var tblContactList : UITableView!

    @IBOutlet var txtSearch : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SetupUI()
    }

    //MARK: - Private Method
    func SetupUI() {
        
        FetchContact().fetchContacts(complation: { (ContactNumbers) in
            print(ContactNumbers)
        })
    }
    
    //MARK: - IBActions
    @IBAction func btnBackPressed(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSearchPressed(_ sender : UIButton) {
    }

}

extension ContactListVC: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}

extension ContactListVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tblContactList.dequeueReusableCell(withIdentifier: "cellContactList") as? cellContactList {
            
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

extension ContactListVC : UITextFieldDelegate {
    
}
