//
//  AudioCallVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 22/06/22.
//

import UIKit

class AudioCallVC: UIViewController {
    
    @IBOutlet var imgUser : UIImageView!
    
    @IBOutlet var lblTime : UILabel!
    @IBOutlet var lblUserName : UILabel!

    @IBOutlet var btnCutCall : UIButton!
    @IBOutlet var btnReciveCall : UIButton!
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
    
    @IBAction func btnVideoPressed(_ sender : UIButton) {
    }
    
    @IBAction func btnSpeckerPressed(_ sender : UIButton) {
    }

    @IBAction func btnMutePressed(_ sender : UIButton) {
    }

    @IBAction func btnRecivePressed(_ sender : UIButton) {
    }

    @IBAction func btnCutPressed(_ sender : UIButton) {
    }

}
