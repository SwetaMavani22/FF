//
//  CreateGroupVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 16/06/22.
//

import UIKit

class CreateGroupVC: UIViewController {
    
    //MARK: - Variables
    @IBOutlet var collectionSelectedMember : UICollectionView!
    @IBOutlet var heightCollection : NSLayoutConstraint!
    
    @IBOutlet var tblUser : UITableView!

    @IBOutlet var txtSearch : UITextField!
    
    var arrUser = ["Anderson", "Ashwoon", "Aikin", "Bateman", "Bongard", "Bowers", "Boyd", "Cannon", "Cast", "Deitz", "Dewalt", "Ebner", "Frick", "Hancock", "Haworth", "Hesch", "Hoffman", "Kassing", "Knutson", "Lawless", "Lawicki", "Mccord", "McCormack", "Miller", "Myers", "Nugent", "Ortiz", "Orwig", "Ory", "Paiser", "Pak", "Pettigrew", "Quinn", "Quizoz", "Ramachandran", "Resnick", "Sagar", "Schickowski", "Schiebel", "Sellon", "Severson", "Shaffer", "Solberg", "Soloman", "Sonderling", "Soukup", "Soulis", "Stahl", "Sweeney", "Tandy", "Trebil", "Trusela", "Trussel", "Turco", "Uddin", "Uflan", "Ulrich", "Upson", "Vader", "Vail", "Valente", "Van Zandt", "Vanderpoel", "Ventotla", "Vogal", "Wagle", "Wagner", "Wakefield", "Weinstein", "Weiss", "Woo", "Yang", "Yates", "Yocum", "Zeaser", "Zeller", "Ziegler", "Bauer", "Baxster", "Casal", "Cataldi", "Caswell", "Celedon", "Chambers", "Chapman", "Christensen", "Darnell", "Davidson", "Davis", "DeLorenzo", "Dinkins", "Doran", "Dugelman", "Dugan", "Duffman", "Eastman", "Ferro", "Ferry", "Fletcher", "Fietzer", "Hylan", "Hydinger", "Illingsworth", "Ingram", "Irwin", "Jagtap", "Jenson", "Johnson", "Johnsen", "Jones", "Jurgenson", "Kalleg", "Kaskel", "Keller", "Leisinger", "LePage", "Lewis", "Linde", "Lulloff", "Maki", "Martin", "McGinnis", "Mills", "Moody", "Moore", "Napier", "Nelson", "Norquist", "Nuttle", "Olson", "Ostrander", "Reamer", "Reardon", "Reyes", "Rice", "Ripka", "Roberts", "Rogers", "Root", "Sandstrom", "Sawyer", "Schlicht", "Schmitt", "Schwager", "Schutz", "Schuster", "Tapia", "Thompson", "Tiernan", "Tisler"]

    var arrSelectedUser = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SetupUI()
    }

    //MARK: - Private Method
    func SetupUI() {
        
        if arrSelectedUser.count > 0 {
            heightCollection.constant = 100
        } else {
            heightCollection.constant = 0
        }
    }
    
    //MARK: - IBActions
    @IBAction func btnBackPressed(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSearchPressed(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnNextPressed(_ sender : UIButton) {
        self.gotoGroupDetailsVC(selectedUser: arrSelectedUser)
    }

}

extension CreateGroupVC : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrSelectedUser.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionSelectedMember.dequeueReusableCell(withReuseIdentifier: "cellSelectedMembers", for: indexPath) as? cellSelectedMembers {
            
            cell.lblUserName.text = arrSelectedUser[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        arrSelectedUser.remove(at: indexPath.row)
        if arrSelectedUser.count > 0 {
            heightCollection.constant = 100
        } else {
            heightCollection.constant = 0
        }
        self.collectionSelectedMember.reloadData()
        self.tblUser.reloadData()
    }
}

extension CreateGroupVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tblUser.dequeueReusableCell(withIdentifier: "cellSelectUser") as? cellSelectUser {
            
            cell.lblUserName.text = arrUser[indexPath.row]
            cell.btnAdd.isHidden = true
            if arrSelectedUser.count > 0 {
                if arrSelectedUser.contains(arrUser[indexPath.row]) {
                    cell.btnAdd.isHidden = false
                } else {
                    cell.btnAdd.isHidden = true
                }
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if !arrSelectedUser.contains(arrUser[indexPath.row]) {
            arrSelectedUser.append(arrUser[indexPath.row])
        } else {
            arrSelectedUser = arrSelectedUser.filter({$0 != arrUser[indexPath.row]})
        }
        if arrSelectedUser.count > 0 {
            heightCollection.constant = 100
        } else {
            heightCollection.constant = 0
        }

        self.collectionSelectedMember.reloadData()
        self.tblUser.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}


extension CreateGroupVC : UITextFieldDelegate {
    
}

