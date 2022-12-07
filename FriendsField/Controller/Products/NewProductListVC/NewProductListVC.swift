//
//  NewProductListVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 17/06/22.
//

import UIKit
import Alamofire

class NewProductListVC: UIViewController {
    
    //MARK: - Variables
    @IBOutlet var collectionProduct : UICollectionView!
    
    var arrProduct = [ModelProductList]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SetupUI()
    }
    
    //MARK: - Private Method
    func SetupUI() {
        
        self.FetchProductData()
    }
    
    func FetchProductData() {

        if (isConnectedToNetwork()) {
            
            let headers: HTTPHeaders = ["authorization" : "bearer \(GlobalUserToken.token)", "Content-Type" : "application/json"]
            
            APIManager.APIGetCalling(API_URL.Url_Product, headers: headers) { (response) in
                //print(response)
                let data = ModelProductData.init(dic: response as? [String:Any] ?? [:])
                if data.Status == API_URL.StatusCode {
                    self.arrProduct = data.Data
                    self.collectionProduct.reloadData()
                } else {
                    self.view.makeToast(data.Message)
                }
            }
        } else {
            self.view.makeToast("Check your network connection")
        }
    }

    
    //MARK: - IBActions
    @IBAction func btnBackPressed(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension NewProductListVC : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrProduct.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let index = indexPath.row + 1
        if (index % 8 == 0 && indexPath.row != 0) {
            if let cell = collectionProduct.dequeueReusableCell(withReuseIdentifier: "cellProductAds", for: indexPath) as? cellProductAds {
                
                return cell
            }
        } else {
            if let cell = collectionProduct.dequeueReusableCell(withReuseIdentifier: "cellNewProduct", for: indexPath) as? cellNewProduct {
                
                let dict = arrProduct[indexPath.row]
                cell.lblProductName.text = dict.name
                cell.lblProductDesc.text = dict.Description
                let price = String(format: "%.01f", (Double(dict.price) ?? 0.0))
                cell.lblProductPrice.text = "\(price)"

                return cell
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.gotoProductDescVC(selectedProduct: arrProduct[indexPath.row] , isFromAllProduct: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionProduct.frame.size.width/2) - 8, height: 230)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

