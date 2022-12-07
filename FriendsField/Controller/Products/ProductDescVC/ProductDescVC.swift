//
//  ProductDescVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 17/05/22.
//

import UIKit
import Alamofire

class ProductDescVC: UIViewController {
    
    //MARK: - Variables
    @IBOutlet var viewNavigation : UIView!
    @IBOutlet var viewPopup: UIView!

    @IBOutlet var lblProductName : UILabel!
    @IBOutlet var lblProductDesc : UILabel!
    @IBOutlet var lblProductPrice : UILabel!
    @IBOutlet var lblProductCode : UILabel!
    @IBOutlet var lblProductDiscount : UILabel!

    @IBOutlet var imgProductImage : UIImageView!
    
    @IBOutlet var btnEdit : UIButton!
    @IBOutlet var btnDelete : UIButton!
    
    @IBOutlet var constrainBtnInquiry : NSLayoutConstraint!

    var selectedProduct = ModelProductList()
    var isFromAllProduct = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SetupUI()
    }

    override func viewDidLayoutSubviews() {
        self.viewNavigation.addBottomShadow()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isFromAllProduct {
            btnEdit.isHidden = true
            btnDelete.isHidden = true
            constrainBtnInquiry.constant = 50
        } else {
            btnEdit.isHidden = false
            btnDelete.isHidden = false
            constrainBtnInquiry.constant = 0
        }

        lblProductName.text = selectedProduct.name
        lblProductDesc.text = selectedProduct.Description
        let price = String(format: "%.01f", (Double(selectedProduct.price) ?? 0.0))
        lblProductPrice.text = "\(price)"
        lblProductCode.text = selectedProduct.itemCode
        lblProductDiscount.text = "\(selectedProduct.offer)% Off"
    }
    
    //MARK: - Private Method
    func SetupUI() {
        
    }
    
    //MARK: - IBActions
    
    @IBAction func btnBackPressed(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnEditPressed(_ sender : UIButton) {
        
        self.gotoAddProductVC(isFromUpdate: true, selectedProduct: selectedProduct, isFromCreateBusiness: false)
    }
    
    @IBAction func btnDeletePressed(_ sender : UIButton) {
        
        AddSubViewtoParentView(parentview: self.view, subview: self.viewPopup)

    }
    
    @IBAction func btnShadowPressed(_ sender : UIButton) {
        
        self.viewPopup.removeFromSuperview()
    }

    @IBAction func btnCancelPressed(_ sender : UIButton) {
        
        self.viewPopup.removeFromSuperview()
    }

    @IBAction func btnDeletePopupPressed(_ sender : UIButton) {
        
        DeleteProduct(id : selectedProduct.id)
    }

    @IBAction func btnclosePressed(_ sender : UIButton) {
        
        self.viewPopup.removeFromSuperview()
    }

    @IBAction func btnInquryMessagePressedPressed(_ sender : UIButton) {
        self.gotoMessageVC(isFromInquiry: true)
    }
}

//MARK: - Database Function
extension ProductDescVC {
    
    func DeleteProduct(id : String) {
        
        if (isConnectedToNetwork()) {
            
            let headers: HTTPHeaders = ["authorization" : "bearer \(GlobalUserToken.token)", "Content-Type" : "application/json"]
            
            APIManager.APIDeleteCalling("\(API_URL.Url_Product)/\(id)", headers: headers) { (response) in
                //print(response)
                let data = ModelProductData.init(dic: response as? [String:Any] ?? [:])
                if data.Status == API_URL.StatusCode {
                    self.navigationController?.popViewController(animated: true)
                } else {
                    self.view.makeToast(data.Message)
                }
            }
        } else {
            self.view.makeToast("Check your network connection")
        }
    }
}
