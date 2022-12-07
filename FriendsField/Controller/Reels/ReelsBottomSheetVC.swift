//
//  ReelsBottomSheet.swift
//  FriendsField
//
//  Created by iMac on 24/08/22.
//

import UIKit

class ReelsBottomSheetVC: UIViewController {
    

    //MARK: - Variables
    
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
}
