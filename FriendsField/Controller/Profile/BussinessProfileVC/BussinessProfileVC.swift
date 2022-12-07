//
//  BussinessProfileVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 16/05/22.
//

import UIKit
import MapKit
import CoreLocation
import Alamofire
import AVFoundation
import AVKit
import PDFKit
import UniformTypeIdentifiers
import MobileCoreServices

class BussinessProfileVC: UIViewController {
    
    //MARK: - Variables
    @IBOutlet var viewNavigation : UIView!
    
    @IBOutlet var txtBussinesName : UITextField!
    @IBOutlet var txtCat : UITextField!
    @IBOutlet var txtSubCat : UITextField!
    @IBOutlet var txtIntrestedBusinessCat : UITextField!
    @IBOutlet var txtIntrestedBusinessSubCat : UITextField!
    
    @IBOutlet var txtViewDesc : UITextView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet var imgProfile : UIImageView!
    @IBOutlet var imgPDF : UIImageView!
    
    @IBOutlet var btnProfileEdit : UIButton!
    @IBOutlet var btnCat : UIButton!
    @IBOutlet var btnBussinesCat : UIButton!
    @IBOutlet var btnBussinesSubCat : UIButton!
    @IBOutlet var btnNext : UIButton!
    
    @IBOutlet var lblNavigation : UILabel!
    
    var locationManager: CLLocationManager!
    let newPin = MKPointAnnotation()
    var imagePicker = UIImagePickerController()
    
    let dropDownCat = DropDown()
    let dropDownBussinesCat = DropDown()
    let dropDownBussinesSubCat = DropDown()
    
    var isUpdateLocation = false
    var isFromUpdate = false
    var lat = 0.0
    var long = 0.0
    
    lazy var dropDowns: [DropDown] = {
        return [
            self.dropDownCat,
            self.dropDownBussinesCat,
            self.dropDownBussinesSubCat
        ]
    }()
    var arrDropdownMenu = ["Cafe","Restaurants","Manufacturing","Sports","Home Decor"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.SetupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isFromUpdate {
            lblNavigation.text = "Edit Business Profile"
            FetchUserBussinesData()
        } else {
            lblNavigation.text = "Create Business Profile"
            self.SetLocation()
        }
    }
    
    override func viewDidLayoutSubviews() {
        self.viewNavigation.addBottomShadow()
        
        if GlobalUserData.isBusinessProfileRegistered {
            btnNext.setTitle("SAVE", for: .normal)
        } else {
            btnNext.setTitle("NEXT", for: .normal)
        }
    }
    
    //MARK: - Private Method
    func SetupUI() {
        
        self.imagePicker.delegate = self
        /*self.setupDropdownCat()
        self.setupDropdownBussinesCat()
        self.setupDropdownBussinesSubCat()*/
    }
    
    func SetLocation() {
        
        mapView.delegate = self
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    func setupDropdownCat() {
        
        dropDownCat.backgroundColor = .white
        dropDownCat.anchorView = btnCat
        dropDownCat.bottomOffset = CGPoint(x: 0, y: btnCat.bounds.height)
        dropDownCat.dataSource = arrDropdownMenu
        
        dropDownCat.selectionAction = {(index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.txtCat.text = item
        }
    }
    
    func setupDropdownBussinesCat() {
        
        dropDownBussinesCat.backgroundColor = .white
        dropDownBussinesCat.anchorView = btnBussinesCat
        dropDownBussinesCat.bottomOffset = CGPoint(x: 0, y: btnBussinesCat.bounds.height)
        dropDownBussinesCat.dataSource = arrDropdownMenu
        
        dropDownBussinesCat.selectionAction = {(index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.txtIntrestedBusinessCat.text = item
        }
    }
    
    func setupDropdownBussinesSubCat() {
        
        dropDownBussinesSubCat.backgroundColor = .white
        dropDownBussinesSubCat.anchorView = btnBussinesSubCat
        dropDownBussinesSubCat.bottomOffset = CGPoint(x: 0, y: btnBussinesSubCat.bounds.height)
        dropDownBussinesSubCat.dataSource = arrDropdownMenu
        
        dropDownBussinesSubCat.selectionAction = {(index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.txtIntrestedBusinessSubCat.text = item
        }
    }
    
    //MARK: - IBActions
    @IBAction func btnBackPressed(_ sender : UIButton) {
        self.isUpdateLocation = false
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNextPressed(_ sender : UIButton) {
        if isValidDetail() {
            self.isUpdateLocation = false
            self.SaveUserBussinesData()
        }
    }
    
    @IBAction func btnCatDropDownPressed(_ sender : UIButton) {
        self.dropDownCat.show()
    }
    
    @IBAction func btnBussinesCatPressed(_ sender : UIButton) {
        self.dropDownBussinesCat.show()
    }
    
    @IBAction func btnBussinesSubCatPressed(_ sender : UIButton) {
        self.dropDownBussinesSubCat.show()
    }
    
    @IBAction func btnProfileEditPressed(_ sender : UIButton) {
        self.OpenGallerySheet()
    }
    
    @IBAction func btnMapPressed(_ sender : UIButton) {
        self.gotoPersonalMapVCFromBusinessProfile(Lat: self.lat, Long: self.long , controller: self)
    }
    
    @IBAction func btnUploadBrochurePressed(_ sender : UIButton) {
        
        let types: [String] = [kUTTypePDF as String]
        let documentPicker = UIDocumentPickerViewController(documentTypes: types, in: .import)
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .formSheet
        self.present(documentPicker, animated: true, completion: nil)
    }

}

extension BussinessProfileVC : UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        
        if let urlString = url.absoluteString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let newUrl = URL(string: urlString), newUrl.pathExtension == "pdf" {
            print("PDF URL: \(newUrl)")
            
            let timestamp = NSDate().timeIntervalSince1970
            let s_Name = "filePDF"
            let uuid = "\(timestamp)"
            let f_Name = "\(s_Name)_\(uuid)"
            let fileName: String = f_Name + (".pdf")

            var PDFDATA = NSData()
            if let videoData = NSData(contentsOf: newUrl) {
                PDFDATA = videoData
            }
            
            DocumentDirectory().SavePDF(pdfData: PDFDATA, pdfName: fileName)
            let img = pdfThumbnail(url: newUrl)
            DispatchQueue.main.async {
                self.imgPDF.image = img
                self.imgPDF.contentMode = .scaleAspectFill
            }

            //adddocumentViewerXibGlobal(vc: self, url: newUrl)
        } else {
            //elf.alert(title: "Alert!", msg: Message.notPDF)
        }
    }
}

extension BussinessProfileVC : UITextFieldDelegate {
    
}

extension BussinessProfileVC : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Description" {
            textView.text = ""
        }
        
        if textView == self.txtViewDesc {
            self.txtViewDesc.becomeFirstResponder()
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Description"
        }
    }
    
}

extension BussinessProfileVC : CLLocationManagerDelegate,MKMapViewDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        mapView.removeAnnotation(newPin)
        let center = CLLocationCoordinate2D(latitude: self.lat, longitude: self.long)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.mapView.setRegion(region, animated: true)
        newPin.coordinate = center
        mapView.addAnnotation(newPin)

        /*mapView.removeAnnotation(newPin)
        
        let location = locations.last! as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.lat = location.coordinate.latitude
        self.long = location.coordinate.longitude
        
        mapView.setRegion(region, animated: true)
        newPin.coordinate = location.coordinate
        mapView.addAnnotation(newPin)*/

    }
    
}

extension BussinessProfileVC : UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
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
            alert.popoverPresentationController?.sourceView = btnProfileEdit
            alert.popoverPresentationController?.sourceRect = btnProfileEdit.bounds
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
            imgProfile.image = chosenImage
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: - Database Functions
extension BussinessProfileVC {
    
    func isValidDetail() -> Bool {
        
        if let name = txtBussinesName.text, name.isEmpty{
            self.view.makeToast("Please Enter Business Name.")
            return false
        }
        
        if let cat = txtCat.text, cat.isEmpty{
            self.view.makeToast("Please Enter Category.")
            return false
        }
        
        if let subCat = txtSubCat.text, subCat.isEmpty{
            self.view.makeToast("Please Enter Business Subcategory.")
            return false
        }
        
        if let desc = txtViewDesc.text, desc.isEmpty{
            self.view.makeToast("Please Enter Description.")
            return false
        }
        
        if let intrestedCat = txtIntrestedBusinessCat.text, intrestedCat.isEmpty{
            self.view.makeToast("Please Enter Intrested Category.")
            return false
        }
        
        if let intrestedSubCat = txtIntrestedBusinessSubCat.text, intrestedSubCat.isEmpty{
            self.view.makeToast("Please Enter Intrested Subcategory.")
            return false
        }
        
        return true
    }
    
    
    func SaveUserBussinesData() {
        
        if (isConnectedToNetwork()) {
            
            let headers: HTTPHeaders = ["authorization" : "bearer \(GlobalUserToken.token)", "Content-Type" : "application/json"]
            
            let params:[String:Any] = ["name": txtBussinesName.text ?? "",
                                       "category": txtCat.text ?? "",
                                       "subCategory": txtSubCat.text ?? "",
                                       "description": txtViewDesc.text ?? "",
                                       "interestedCategory": txtIntrestedBusinessCat.text ?? "",
                                       "interestedSubCategory": txtIntrestedBusinessSubCat.text ?? "",
                                       "longitude":self.long,
                                       "latitude" : self.lat]
            if isFromUpdate {
                APIManager.APIPatchCalling(API_URL.Url_FetchBussinesProfile, headers: headers,params: params) { (response) in
                    //print(response)
                    let data = ModelBussinesProfile.init(dic: response as? [String:Any] ?? [:])
                    if data.Status == API_URL.StatusCode {
                        GlobalBussinesData = data.Data
                        do {
                            let encodedData = try NSKeyedArchiver.archivedData(withRootObject: GlobalBussinesData, requiringSecureCoding: false)
                            Defualtss.set(encodedData, forKey: UDKey.kUserBussinesData)
                            if self.btnNext.currentTitle == "SAVE" {
                                self.navigationController?.popViewController(animated: true)
                            } else {
                                self.gotoAddProductVC(isFromUpdate: false, selectedProduct: ModelProductList(), isFromCreateBusiness: true)
                            }
                        } catch {
                            print("Something went wrong.")
                        }
                    } else {
                        self.view.makeToast(data.Message)
                    }
                }
            } else {
                APIManager.APIPostCalling(API_URL.Url_CreateBussinesProfile, headers: headers,params: params) { (response) in
                    //print(response)
                    let data = ModelBussinesProfile.init(dic: response as? [String:Any] ?? [:])
                    if data.Status == API_URL.StatusCode {
                        GlobalBussinesData = data.Data
                        do {
                            let encodedData = try NSKeyedArchiver.archivedData(withRootObject: GlobalBussinesData, requiringSecureCoding: false)
                            Defualtss.set(encodedData, forKey: UDKey.kUserBussinesData)
                            self.gotoAddProductVC(isFromUpdate: false, selectedProduct: ModelProductList(), isFromCreateBusiness: true)
                        } catch {
                            print("Something went wrong.")
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
    
    func FetchUserBussinesData() {
        
        if (isConnectedToNetwork()) {
            
            let headers: HTTPHeaders = ["authorization" : "bearer \(GlobalUserToken.token)", "Content-Type" : "application/json"]
            
            APIManager.APIGetCalling(API_URL.Url_FetchBussinesProfile, headers: headers) { (response) in
                //print(response)
                let data = ModelBussinesProfile.init(dic: response as? [String:Any] ?? [:])
                if data.Status == API_URL.StatusCode {
                    self.txtBussinesName.text = data.Data.name
                    self.txtCat.text = data.Data.category
                    self.txtSubCat.text = data.Data.subCategory
                    self.txtIntrestedBusinessCat.text = data.Data.interestedCategory
                    self.txtIntrestedBusinessSubCat.text = data.Data.interestedSubCategory
                    self.txtViewDesc.text = data.Data.Description
                    if !self.isUpdateLocation {
                        self.lat = Double(data.Data.latitude) ?? 0.0
                        self.long = Double(data.Data.longitude) ?? 0.0
                        self.SetLocation()
                    }
                } else {
                    self.view.makeToast(data.Message)
                }
            }
        } else {
            self.view.makeToast("Check your network connection")
        }
    }
}

extension BussinessProfileVC : SelectedLocation {
    
    func DelegateSelectedLocation(lat: Double, long: Double) {
        self.lat = lat
        self.long = long
        self.isUpdateLocation = true
        self.SetLocation()
    }
}
