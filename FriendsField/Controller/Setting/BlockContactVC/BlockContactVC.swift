//
//  BlockContactVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 20/05/22.
//

import UIKit

class BlockContactVC: UIViewController {
    
    //MARK: - Variables
    @IBOutlet var tblBlockCallData : UITableView!

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

extension BlockContactVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tblBlockCallData.dequeueReusableCell(withIdentifier: "cellBlockCall") as? cellBlockCall {
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
