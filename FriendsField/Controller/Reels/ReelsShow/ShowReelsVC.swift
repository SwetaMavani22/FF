//
//  ShowReelsVC.swift
//  FriendsField
//
//  Created by iMac on 25/08/22.
//

import UIKit

class ShowReelsVC: UIViewController {
        
    @IBOutlet var tblReels : UITableView!

    //MARK: - Variables
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SetupUI()
    }
    
    override func viewDidLayoutSubviews() {
    }

    //MARK: - Private Method
    func SetupUI() {
        
    }

    //MARK: - IBActions
    @IBAction func btnBackPressed(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCreateReelsPressed(_ sender : UIButton) {
        self.gotoUploadReelsVC()
    }
        
    @objc func btnCommentPressed(_ sender: UIButton){
        
        print(sender.tag)
        let bottomSheetVC = UIStoryboard.instantiateViewController(storyborad: .main,withViewClass: ReelsCommentVC.self)
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

    @objc func btnMorePressed(_ sender: UIButton){
        
        print(sender.tag)
        let bottomSheetVC = UIStoryboard.instantiateViewController(storyborad: .main,withViewClass: ReelsBottomSheetVC.self)
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


}

extension ShowReelsVC:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tblReels.dequeueReusableCell(withIdentifier: "cellReelsVideo") as? cellReelsVideo {
            
            cell.btnComment.tag = indexPath.row
            cell.btnComment.addTarget(self, action: #selector(btnCommentPressed(_:)), for: UIControl.Event.touchUpInside)

            cell.btnMore.tag = indexPath.row
            cell.btnMore.addTarget(self, action: #selector(btnMorePressed(_:)), for: UIControl.Event.touchUpInside)

            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tblReels.frame.size.height
    }
    
}
