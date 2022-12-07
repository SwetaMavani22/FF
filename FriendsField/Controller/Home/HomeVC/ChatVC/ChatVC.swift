//
//  ChatVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 18/05/22.
//

import UIKit
import JXSegmentedView

class ChatVC: UIViewController {
    
    //MARK: - Variables
    @IBOutlet var tblChatData : UITableView!

    @IBOutlet var lblNotificationTime : UILabel!
    @IBOutlet var lblNotificationCount : UILabel!

    @IBOutlet var txtSearch : UITextField!
    
    var parentView = UIViewController()

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
    
    @IBAction func btnReeldPressed(_ sender : UIButton) {
        self.gotoShowReelsVC()
    }

    @IBAction func btnFilterPressed(_ sender : UIButton) {
        
        let bottomSheetVC = UIStoryboard.instantiateViewController(storyborad: .main,withViewClass: BottomSheetVC.self)

        if #available(iOS 15.0, *) {
            if let presentationController = bottomSheetVC.presentationController as? UISheetPresentationController {
                presentationController.preferredCornerRadius = 30.0
                presentationController.prefersGrabberVisible = true
                presentationController.detents = [.medium()]
                //presentationController.presentedView?.size.height = 100.0
            }
        } else {
            self.view.makeToast("Oops...!Your Device version is lower to use filter.")
        }
        
        self.present(bottomSheetVC, animated: true)
    }

    @IBAction func btnSearchPressed(_ sender : UIButton) {
    }
    
    @IBAction func btnNotificationPressed(_ sender : UIButton) {
        self.gotoNotificationVC()
    }

}

extension ChatVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tblChatData.dequeueReusableCell(withIdentifier: "cellChat") as? cellChat {
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.gotoMessageVC(isFromInquiry: false)
        //self.gotoGroupDetailVC()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension ChatVC: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}

extension ChatVC : UITextFieldDelegate {
    
}
