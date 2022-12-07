//
//  GroupDetailVC.swift
//  FriendsField
//
//  Created by iMac on 18/08/22.
//

import UIKit

class GroupDetailVC: UIViewController {
    
    @IBOutlet var viewPopup : UIView!
    @IBOutlet var viewUserPopup : UIView!

    @IBOutlet var tblGroupMembers : UITableView!
    
    @IBOutlet var lblGroupName : UILabel!
    @IBOutlet var lblGroupDes : UILabel!
    @IBOutlet var lblGroupExitName : UILabel!
    @IBOutlet var lblGroupReportName : UILabel!

    
    @IBOutlet var heightTbl : NSLayoutConstraint!
    @IBOutlet var btnShowMore : UIButton!
    
    //MARK: - Variables
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SetupUI()
    }
    
    override func viewDidLayoutSubviews() {
    }

    //MARK: - Private Method
    func SetupUI() {
        
        heightTbl.constant = 70 * 3
        btnShowMore.setTitle("Show More", for: .normal)
    }

    //MARK: - IBActions
    @IBAction func btnBackPressed(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSearchPressed(_ sender : UIButton) {
    }

    @IBAction func btnAddMembersPressed(_ sender : UIButton) {
    }

    @IBAction func btnAcessPermissionPressed(_ sender : UIButton) {
        AddSubViewtoParentView(parentview: self.view, subview: self.viewPopup)
    }

    @IBAction func btnAudioCallPressed(_ sender : UIButton) {
    }
    
    @IBAction func btnVideoCallPressed(_ sender : UIButton) {
    }

    @IBAction func btnClearChatPressed(_ sender : UIButton) {
    }

    @IBAction func btnExitGroupPressed(_ sender : UIButton) {
    }
    
    @IBAction func btnReportGroupPressed(_ sender : UIButton) {
    }

    @IBAction func btnEditGroupImagePressed(_ sender : UIButton) {
    }

    @IBAction func btnEditGroupDetailsPressed(_ sender : UIButton) {
        self.gotoEditGroupDetailsVC()
    }

    @IBAction func btnClosePressed(_ sender : UIButton) {
        self.viewPopup.removeFromSuperview()
    }

    @IBAction func switchVideoCallPressed(_ sender : UISwitch) {
    }
    
    @IBAction func switchVoiceCallPressed(_ sender : UISwitch) {
    }
        
    @IBAction func switchFullNamePressed(_ sender : UISwitch) {
    }

    @IBAction func switchPhoneNumberPressed(_ sender : UISwitch) {
    }

    @IBAction func switchEmailPressed(_ sender : UISwitch) {
    }

    @IBAction func switchSocialMediaPressed(_ sender : UISwitch) {
    }
    
    @IBAction func switchMuteNotificationPressed(_ sender : UISwitch) {
    }

    @IBAction func btnShowMoerePressed(_ sender : UIButton) {
        if btnShowMore.titleLabel?.text == "Show More" {
            heightTbl.constant = 70 * 10
            btnShowMore.setTitle("Show Less", for: .normal)
        } else {
            heightTbl.constant = 70 * 3
            btnShowMore.setTitle("Show More", for: .normal)
        }
    }

    @IBAction func btnCloseUserPopupPressed(_ sender : UIButton) {
        self.viewUserPopup.removeFromSuperview()
    }

}

extension GroupDetailVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tblGroupMembers.dequeueReusableCell(withIdentifier: "cellGroupMembers") as? cellGroupMembers {
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        AddSubViewtoParentView(parentview: self.view, subview: self.viewUserPopup)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
