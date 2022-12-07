//
//  HelpVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 21/05/22.
//

import UIKit
import ExpyTableView

//https://github.com/okhanokbay/ExpyTableView

class HelpVC: UIViewController {
    
    //MARK: - Variables
    @IBOutlet weak var tblHelp : ExpyTableView!

    @IBOutlet var viewNavigation : UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SetupUI()
    }

    override func viewDidLayoutSubviews() {
        self.viewNavigation.addBottomShadow()
    }

    //MARK: - Private Method
    func SetupUI() {
        
        self.setUpTableview()
    }
    
    func setUpTableview() {
        
        tblHelp.dataSource = self
        tblHelp.delegate = self
    
        tblHelp.rowHeight = UITableView.automaticDimension
        tblHelp.estimatedRowHeight = 60
    
        //Alter the animations as you want
        tblHelp.expandingAnimation = .fade
        tblHelp.collapsingAnimation = .fade
        tblHelp.tableFooterView = UIView()

    }
    
    //MARK: - IBActions
    @IBAction func btnBackPressed(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension HelpVC: ExpyTableViewDataSource {
    
    func tableView(_ tableView: ExpyTableView, canExpandSection section: Int) -> Bool {
        return true
    }
    
    func tableView(_ tableView: ExpyTableView, expandableCellForSection section: Int) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: "cellHeader")) as! cellHeader
        cell.layoutMargins = UIEdgeInsets.zero
        cell.showSeparator()
        return cell
    }
}

//MARK: ExpyTableView delegate methods
extension HelpVC: ExpyTableViewDelegate {
    func tableView(_ tableView: ExpyTableView, expyState state: ExpyState, changeForSection section: Int) {
    
        switch state {
        case .willExpand:
            print("WILL EXPAND")
            
        case .willCollapse:
            print("WILL COLLAPSE")
            
        case .didExpand:
            print("DID EXPAND")
            
        case .didCollapse:
            print("DID COLLAPSE")
        }
    }
}

extension HelpVC {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
}

extension HelpVC {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        print("DID SELECT row: \(indexPath.row), section: \(indexPath.section)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//MARK: UITableView Data Source Methods
extension HelpVC {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2 // +1 here is for BuyTableViewCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: "cellRow")) as! cellRow
            cell.layoutMargins = UIEdgeInsets.zero
            cell.hideSeparator()
            return cell
    }
}
