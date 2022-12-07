//
//  AddProductVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 17/05/22.
//

import UIKit
import Alamofire

class AddProductVC: UIViewController {
    
    //MARK: - Variables
    @IBOutlet var viewNavigation : UIView!
    
    @IBOutlet var lblNavigation : UILabel!

    @IBOutlet var txtProductName : UITextField!
    @IBOutlet var txtProductPrice : UITextField!
    @IBOutlet var txtProductOffer : UITextField!
    @IBOutlet var txtProductCode : UITextField!
    @IBOutlet var txtCat : UITextField!
    @IBOutlet var txtSubCat : UITextField!

    @IBOutlet var txtProductDesc : UITextView!

    @IBOutlet var imgProduct : UIImageView!
    @IBOutlet var btnProduct : UIButton!

    var imagePicker = UIImagePickerController()

    var isFromUpdate = false
    var isFromCreateBusiness = false
    var selectedProduct = ModelProductList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SetupUI()
    }

    override func viewDidLayoutSubviews() {
        self.viewNavigation.addBottomShadow()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isFromUpdate {
            txtProductName.text = selectedProduct.name
            txtProductDesc.text = selectedProduct.Description
            txtProductCode.text = selectedProduct.itemCode
            txtProductPrice.text = selectedProduct.price
            txtProductOffer.text = selectedProduct.offer
            txtCat.text = selectedProduct.category
            txtSubCat.text = selectedProduct.subCategory
            lblNavigation.text = "Edit Product"
        } else {
            lblNavigation.text = "Add Product"
        }
    }
    
    //MARK: - Private Method
    func SetupUI() {
        
        self.imagePicker.delegate = self
    }
    
    //MARK: - IBActions
    @IBAction func btnBackPressed(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSavePressed(_ sender : UIButton) {
        if isValidDetail() {
            self.SaveProductData()
        }
    }

    @IBAction func btnAddImagePressed(_ sender : UIButton) {
        self.OpenGallerySheet()
    }
}

extension AddProductVC : UITextFieldDelegate {
    
}

extension AddProductVC : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Product Description" {
            textView.text = ""
        }
        
        if textView == self.txtProductDesc {
            self.txtProductDesc.becomeFirstResponder()
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Product Description"
        }
    }

}

extension AddProductVC : UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    func OpenGallerySheet() {
        
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = btnProduct
            alert.popoverPresentationController?.sourceRect = btnProduct.bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallary() {
        
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       if let chosenImage = info[.originalImage] as? UIImage{
           imgProduct.image = chosenImage
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }

}

//MARK: - Database Functions
extension AddProductVC {
    
    func isValidDetail() -> Bool {
        
        if let name = txtProductName.text, name.isEmpty{
            self.view.makeToast("Please Enter Product Name.")
            return false
        }
        
        if let price = txtProductPrice.text, price.isEmpty{
            self.view.makeToast("Please Enter Product Price.")
            return false
        }
        
        if let offer = txtProductOffer.text, offer.isEmpty{
            self.view.makeToast("Please Enter Product Offer.")
            return false
        }
                
        if let code = txtProductCode.text, code.isEmpty{
            self.view.makeToast("Please Enter Product Code.")
            return false
        }
        
        if let desc = txtProductDesc.text, desc.isEmpty{
            self.view.makeToast("Please Enter Product Description.")
            return false
        }

        return true
    }
    
    
    func SaveProductData() {
        
        if (isConnectedToNetwork()) {
            
            let headers: HTTPHeaders = ["authorization" : "bearer \(GlobalUserToken.token)", "Content-Type" : "application/json"]
            
            let params:[String:Any] = ["name": txtProductName.text ?? "",
                                       "description": txtProductDesc.text ?? "",
                                       "offer": txtProductOffer.text ?? "",
                                       "price": txtProductPrice.text ?? "",
                                       "category": txtCat.text ?? "",
                                       "subCategory" : txtSubCat.text ?? "",
                                       "itemCode": txtProductCode.text ?? ""]
            
            if isFromUpdate {
                APIManager.APIPatchCalling("\(API_URL.Url_Product)/\(selectedProduct.id)", headers: headers,params: params) { (response) in
                    print(response)
                    let data = ModelProductData.init(dic: response as? [String:Any] ?? [:])
                    if data.Status == API_URL.StatusCode {
                        if self.isFromCreateBusiness {
                            self.gotoUserProfileVC()
                        } else {
                            self.navigationController?.popViewController(animated: true)
                        }
                    } else {
                        self.view.makeToast(data.Message)
                    }
                }
            } else {
                APIManager.APIPostCalling(API_URL.Url_Product, headers: headers,params: params) { (response) in
                    //print(response)
                    let data = ModelProductData.init(dic: response as? [String:Any] ?? [:])
                    if data.Status == API_URL.StatusCode {
                        if self.isFromCreateBusiness {
                            self.gotoUserProfileVC()
                        } else {
                            self.navigationController?.popViewController(animated: true)
                        }
                    } else {
                        self.view.makeToast(data.Message)
                    }
                }
            }
        } else {
            self.view.makeToast("Check your network connection")
        }
    }
}
