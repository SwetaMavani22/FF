//
//  LikeCommentVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 15/06/22.
//

import UIKit

class LikeCommentVC: UIViewController {
    
    //MARK: - Variables
    @IBOutlet var tblLikeAndComment : UITableView!

    @IBOutlet var viewNavigation : UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SetupUI()
    }

    //MARK: - Private Method
    func SetupUI() {
        
    }
    
    override func viewDidLayoutSubviews() {
        self.viewNavigation.addBottomShadow()
    }

    //MARK: - IBActions
    @IBAction func btnBackPressed(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension LikeCommentVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = indexPath.row + 1
        if (index % 6 == 0 && indexPath.row != 0) {
            let cellBanner = tblLikeAndComment.dequeueReusableCell(withIdentifier: "cellAds", for: indexPath) as! cellAds

            return cellBanner
        } else {
            if let cell = tblLikeAndComment.dequeueReusableCell(withIdentifier: "cellLikeAndComment") as? cellLikeAndComment {
                
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

