//
//  ProductVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 17/05/22.
//

import UIKit
import Alamofire

class ProductListVC: UIViewController {
    
    //MARK: - Variables
    @IBOutlet var viewNavigation : UIView!
    @IBOutlet var viewAddProduct : UIView!
    @IBOutlet var viewAddProductBottom : UIView!
    @IBOutlet var viewSkipNow : UIView!
    @IBOutlet var viewPopup: UIView!

    @IBOutlet var imgProduct : UIImageView!
    @IBOutlet var btnProduct : UIButton!

    @IBOutlet var tblProductData : UITableView!
    
    @IBOutlet var btnAddProduct : UIButton!
    
    @IBOutlet var lblProductName : UILabel!
    @IBOutlet var lblProductDesc : UILabel!
    
    var arrProduct = [ModelProductList]()
    var selectedProduct = ModelProductList()
    
    var dictBussinesData = ModelBussinesData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SetupUI()
    }

    override func viewDidLayoutSubviews() {
        self.viewNavigation.addBottomShadow()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.FetchUserBussinesData()
        self.FetchProductData()
    }
    
    //MARK: - Private Method
    func SetupUI() {
        
        self.viewSkipNow.isHidden = true
        self.viewAddProductBottom.isHidden = true
        self.viewAddProduct.isHidden = true
    }
    
    //MARK: - IBActions
    
    @IBAction func btnBackPressed(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnSkipNowPressed(_ sender : UIButton) {
        self.gotoHomeVC()
    }
    
    @IBAction func btnAddProductPressed(_ sender : UIButton) {
        self.gotoAddProductVC(isFromUpdate: false, selectedProduct: ModelProductList(), isFromCreateBusiness: false)
    }
    
    @IBAction func btnSavePressed(_ sender : UIButton) {
        
    }
    
    @IBAction func btnProductImageEditPressed(_ sender : UIButton) {
        gotoBussinessProfileVC(isFromUpdate: true)
    }
    
    @IBAction func btnShadowPressed(_ sender : UIButton) {
        
        self.viewPopup.removeFromSuperview()
    }

    @IBAction func btnCancelPressed(_ sender : UIButton) {
        
        self.viewPopup.removeFromSuperview()
    }

    @IBAction func btnDeletePopupPressed(_ sender : UIButton) {
        
        self.DeleteProduct(id: selectedProduct.id)
    }

    @IBAction func btnclosePressed(_ sender : UIButton) {
        
        self.viewPopup.removeFromSuperview()
    }


}

extension ProductListVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrProduct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tblProductData.dequeueReusableCell(withIdentifier: "cellProduct") as? cellProduct {
            
            let dict = arrProduct[indexPath.row]
            cell.lblProductName.text = dict.name
            cell.lblProductDesc.text = dict.Description
            
            if dict.offer != "" {
                cell.lblProductDiscount.text = "\(dict.offer)% Off"
                cell.lblProductDiscount.isHidden = false
            } else {
                cell.lblProductDiscount.isHidden = true
            }
            let price = String(format: "%.01f", (Double(dict.price) ?? 0.0))
            cell.lblProductPrice.text = "\(price)"
            
            cell.btnEdit.addTarget(self, action: #selector(btnEditPressed(sender:)), for: .touchUpInside)
            cell.btnEdit.tag = indexPath.row
            
            cell.btnDelete.addTarget(self, action: #selector(btnDeletePressed(sender:)), for: .touchUpInside)
            cell.btnDelete.tag = indexPath.row

            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.gotoProductDescVC(selectedProduct: arrProduct[indexPath.row], isFromAllProduct: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    @objc func btnEditPressed(sender: UIButton){        
        self.gotoAddProductVC(isFromUpdate: true, selectedProduct: arrProduct[sender.tag], isFromCreateBusiness: false)
    }

    @objc func btnDeletePressed(sender: UIButton){
        
        AddSubViewtoParentView(parentview: self.view, subview: self.viewPopup)
        selectedProduct = arrProduct[sender.tag]
    }

}

//MARK: - Database Function
extension ProductListVC {
    
    func FetchUserBussinesData() {
        
        if (isConnectedToNetwork()) {
            
            let headers: HTTPHeaders = ["authorization" : "bearer \(GlobalUserToken.token)", "Content-Type" : "application/json"]
            
            APIManager.APIGetCalling(API_URL.Url_FetchBussinesProfile, headers: headers) { (response) in
                //print(response)
                let data = ModelBussinesProfile.init(dic: response as? [String:Any] ?? [:])
                if data.Status == API_URL.StatusCode {
                    self.dictBussinesData = data.Data
                    self.lblProductName.text = self.dictBussinesData.name
                    self.lblProductDesc.text = self.dictBussinesData.Description
                } else {
                    self.view.makeToast(data.Message)
                }
            }
        } else {
            self.view.makeToast("Check your network connection")
        }
    }
    
    func FetchProductData() {

        if (isConnectedToNetwork()) {
            
            let headers: HTTPHeaders = ["authorization" : GlobalUserToken.token, "Content-Type" : "application/json"]
            
            APIManager.APIGetCalling(API_URL.Url_Product, headers: headers) { (response) in
                //print(response)
                let data = ModelProductData.init(dic: response as? [String:Any] ?? [:])
                if data.Status == API_URL.StatusCode {
                    self.arrProduct = data.Data
                    self.tblProductData.reloadData()
                    if self.arrProduct.count > 0 {
                        self.viewSkipNow.isHidden = true
                        self.viewAddProductBottom.isHidden = true
                        self.viewAddProduct.isHidden = false
                    } else {
                        self.viewSkipNow.isHidden = false
                        self.viewAddProductBottom.isHidden = false
                        self.viewAddProduct.isHidden = true
                    }
                } else {
                    self.view.makeToast(data.Message)
                }
            }
        } else {
            self.view.makeToast("Check your network connection")
        }
    }

    func DeleteProduct(id : String) {
        
        if (isConnectedToNetwork()) {
            
            let headers: HTTPHeaders = ["authorization" : "bearer \(GlobalUserToken.token)", "Content-Type" : "application/json"]
            
            APIManager.APIDeleteCalling("\(API_URL.Url_Product)/\(id)", headers: headers) { (response) in
                //print(response)
                let data = ModelProductData.init(dic: response as? [String:Any] ?? [:])
                if data.Status == API_URL.StatusCode {
                    self.viewPopup.removeFromSuperview()
                    self.FetchProductData()
                } else {
                    self.view.makeToast(data.Message)
                }
            }
        } else {
            self.view.makeToast("Check your network connection")
        }
    }
}
