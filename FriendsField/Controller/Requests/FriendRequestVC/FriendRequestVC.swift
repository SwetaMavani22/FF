//
//  FriendRequestVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 20/05/22.
//

import UIKit
import JXSegmentedView

class FriendRequestVC: UIViewController {
    
    //MARK: - Variables
    @IBOutlet var tblFriendRequestData : UITableView!

    @IBOutlet var viewRejectRequest : UIView!
    @IBOutlet var viewAcceptRequest : UIView!
    
    @IBOutlet weak var lblPopUpPhoneNumber: UILabel!
    @IBOutlet weak var lblPopupEmail: UILabel!
    @IBOutlet weak var lblPopupName: UILabel!
    @IBOutlet weak var lblPopupSocialMedia: UILabel!

    var ParentView = UIView()
    
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
    
    @IBAction func btnPopupRejectPressed(_ sender : UIButton) {
    }

    @IBAction func btnPopupBlockPressed(_ sender : UIButton) {
    }

    @IBAction func btnPopUpRejectClosePressed(_ sender : UIButton) {
        self.viewRejectRequest.removeFromSuperview()
    }

    @IBAction func btnPopupRejectShadowPressed(_ sender : UIButton) {
        self.viewRejectRequest.removeFromSuperview()
    }

    @IBAction func btnPopUpAcceptShadowPressed(_ sender : UIButton) {
        self.viewAcceptRequest.removeFromSuperview()
    }

    @IBAction func btnPopUpAcceptClosePressed(_ sender : UIButton) {
        self.viewAcceptRequest.removeFromSuperview()
    }

    @IBAction func btnPopupAcceptPressed(_ sender : UIButton) {
    }
    
    @IBAction func btnPopupCancelPressed(_ sender : UIButton) {
        self.viewAcceptRequest.removeFromSuperview()
    }

    @IBAction func switchFullNamePressed(_ sender : UISwitch) {
    }

    @IBAction func switchPhoneNumberPressed(_ sender : UISwitch) {
    }

    @IBAction func switchEmailPressed(_ sender : UISwitch) {
    }

    @IBAction func switchSocialMediaPressed(_ sender : UISwitch) {
    }

    @objc func btnAcceptRequestPressed(sender: UIButton){
        print(sender.tag)
        AddSubViewtoParentView(parentview: ParentView, subview: self.viewAcceptRequest)
    }
    
    @objc func btnRejectRequestPressed(sender: UIButton){
        print(sender.tag)
        AddSubViewtoParentView(parentview: ParentView, subview: self.viewRejectRequest)
    }
}

extension FriendRequestVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tblFriendRequestData.dequeueReusableCell(withIdentifier: "cellFriendRequest") as? cellFriendRequest {
            
            cell.btnAccept.tag = indexPath.row
            cell.btnAccept.addTarget(self, action: #selector(btnAcceptRequestPressed(sender:)), for: .touchUpInside)

            cell.btnReject.tag = indexPath.row
            cell.btnReject.addTarget(self, action: #selector(btnRejectRequestPressed(sender:)), for: .touchUpInside)

            return cell
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
}

extension FriendRequestVC: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}
