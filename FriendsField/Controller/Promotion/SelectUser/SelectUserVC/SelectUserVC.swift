//
//  SelectUserVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 18/06/22.
//

import UIKit

class SelectUserVC: UIViewController {

    @IBOutlet var lblSelectUserCount : UILabel!
    
    @IBOutlet var btnSelect : UIButton!
    
    @IBOutlet var tblSelectUser : UITableView!

    @IBOutlet var viewNavigation : UIView!

    @IBOutlet var txtSearch : UITextField!
    
    var isSelectAll = false

    var arrUser = ["Anderson", "Ashwoon", "Aikin", "Bateman", "Bongard", "Bowers", "Boyd", "Cannon", "Cast", "Deitz", "Dewalt", "Ebner", "Frick", "Hancock", "Haworth", "Hesch", "Hoffman", "Kassing", "Knutson", "Lawless", "Lawicki", "Mccord", "McCormack", "Miller", "Myers", "Nugent", "Ortiz", "Orwig", "Ory", "Paiser", "Pak", "Pettigrew", "Quinn", "Quizoz", "Ramachandran", "Resnick", "Sagar", "Schickowski", "Schiebel", "Sellon", "Severson", "Shaffer", "Solberg", "Soloman", "Sonderling", "Soukup", "Soulis", "Stahl", "Sweeney", "Tandy", "Trebil", "Trusela", "Trussel", "Turco", "Uddin", "Uflan", "Ulrich", "Upson", "Vader", "Vail", "Valente", "Van Zandt", "Vanderpoel", "Ventotla", "Vogal", "Wagle", "Wagner", "Wakefield", "Weinstein", "Weiss", "Woo", "Yang", "Yates", "Yocum", "Zeaser", "Zeller", "Ziegler", "Bauer", "Baxster", "Casal", "Cataldi", "Caswell", "Celedon", "Chambers", "Chapman", "Christensen", "Darnell", "Davidson", "Davis", "DeLorenzo", "Dinkins", "Doran", "Dugelman", "Dugan", "Duffman", "Eastman", "Ferro", "Ferry", "Fletcher", "Fietzer", "Hylan", "Hydinger"]
    
    var arrSelectedUser = [String]()
    var arrSelectedAllUser = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SetupUI()
    }

    override func viewDidLayoutSubviews() {
        self.viewNavigation.addBottomShadow()
    }

    //MARK: - Private Method
    func SetupUI() {
        arrSelectedAllUser = arrUser
        lblSelectUserCount.text = "\(arrSelectedUser.count) People Selected"
    }
    
    //MARK: - IBActions
    @IBAction func btnBackPressed(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSearchPressed(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnSelectAllPressed(_ sender : UIButton) {
        
        isSelectAll = !isSelectAll
        if isSelectAll {
            arrSelectedUser = arrSelectedAllUser
            btnSelect.setImage(UIImage(named:  "ic_Select_User"), for: .normal)
        } else {
            arrSelectedUser.removeAll()
            btnSelect.setImage(UIImage(named:  "ic_Deselect_User"), for: .normal)
        }
        lblSelectUserCount.text = "\(arrSelectedUser.count) People Selected"
        self.tblSelectUser.reloadData()
    }

    @IBAction func btnNextPressed(_ sender : UIButton) {
        self.gotoStartPromotionVC()
    }
    
    @IBAction func btnFilterPressed(_ sender : UIButton) {
        
        let bottomSheetVC = UIStoryboard.instantiateViewController(storyborad: .main,withViewClass: FilterUserPopUpVC.self)

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

extension SelectUserVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tblSelectUser.dequeueReusableCell(withIdentifier: "cellSelectUserForPromotion") as? cellSelectUserForPromotion {
            
            cell.lblName.text = arrUser[indexPath.row]
            if isSelectAll {
                cell.btnSelect.setImage(UIImage(named:  "ic_Select_User"), for: .normal)
            } else {
                if arrSelectedUser.count > 0 {
                    if arrSelectedUser.contains(arrUser[indexPath.row]) {
                        cell.btnSelect.setImage(UIImage(named:  "ic_Select_User"), for: .normal)
                    } else {
                        cell.btnSelect.setImage(UIImage(named:  "ic_Deselect_User"), for: .normal)
                    }
                } else {
                    cell.btnSelect.setImage(UIImage(named:  "ic_Deselect_User"), for: .normal)
                }
            }

            cell.btnSelect.tag = indexPath.row
            cell.btnSelect.addTarget(self, action: #selector(btnSelectUserPressed(sender:)), for: .touchUpInside)

            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    @objc func btnSelectUserPressed(sender: UIButton){
        
        if !arrSelectedUser.contains(arrUser[sender.tag]) {
            arrSelectedUser.append(arrUser[sender.tag])
        } else {
            arrSelectedUser = arrSelectedUser.filter({$0 != arrUser[sender.tag]})
        }
        lblSelectUserCount.text = "\(arrSelectedUser.count) People Selected"
        self.tblSelectUser.reloadData()
    }

}

extension SelectUserVC : UITextFieldDelegate {
    
}
