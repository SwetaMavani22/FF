//
//  ViewController.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 16/05/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var viewNavigation : UIView!

    //MARK: - Variables
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SetupUI()
    }
    
    override func viewDidLayoutSubviews() {
        self.viewNavigation.addBottomShadow()
    }

    //MARK: - Private Method
    func SetupUI() {
        
    }

    //MARK: - IBActions
    @IBAction func btnBackPressed(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

