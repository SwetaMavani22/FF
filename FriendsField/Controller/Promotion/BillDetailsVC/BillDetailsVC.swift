//
//  BillDetailsVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 21/06/22.
//

import UIKit

class BillDetailsVC: UIViewController {
    
    @IBOutlet var viewNavigation : UIView!
    
    @IBOutlet var imgProduct : UIImageView!
    
    @IBOutlet var lblProductTitle : UILabel!
    @IBOutlet var lblProductDesc : UILabel!
    @IBOutlet var lblProductWeb : UILabel!
    @IBOutlet var lblPublishDate : UILabel!
    @IBOutlet var lblTransactionDate : UILabel!
    @IBOutlet var lblTransactionID : UILabel!
    @IBOutlet var lblPaymentStatus : UILabel!
    
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
    
    @IBAction func btnOkPressed(_ sender : UIButton) {
    }

    @IBAction func btnDownloadInvoicePressed(_ sender : UIButton) {
    }

}
