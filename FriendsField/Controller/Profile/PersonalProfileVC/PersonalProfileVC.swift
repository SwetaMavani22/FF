//
//  CreateProfileVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 16/05/22.
//

import UIKit
import RangeSeekSlider
import MapKit
import CoreLocation
import Alamofire
import SSCTaglistView

class PersonalProfileVC: UIViewController {
    
    //MARK: - Variables
    @IBOutlet var viewNavigation : UIView!
    @IBOutlet var viewMale : UIView!
    @IBOutlet var viewFemale : UIView!
    @IBOutlet var viewOther : UIView!
    @IBOutlet var viewGender : UIView!
    @IBOutlet var viewTag: UIView!

    @IBOutlet var txtFullName : UITextField!
    @IBOutlet var txtNickName : UITextField!
    @IBOutlet var txtEmail : UITextField!
    @IBOutlet var txtFacebook : UITextField!
    @IBOutlet var txtInsta : UITextField!
    @IBOutlet var txtTwitter : UITextField!
    @IBOutlet var txtLinkedIn : UITextField!
    @IBOutlet var txtPintrest : UITextField!
    @IBOutlet var txtYoutube : UITextField!
    @IBOutlet var txtHobbies : UITextField!
    @IBOutlet var txtUserGender : UITextField!
    @IBOutlet var txtDate : UITextField!

    @IBOutlet var txtAboutus : UITextView!
    
    @IBOutlet var lblKm : UILabel!
    @IBOutlet var lblAge : UILabel!
    @IBOutlet var lblMale : UILabel!
    @IBOutlet var lblFemale : UILabel!
    @IBOutlet var lblOther : UILabel!
    @IBOutlet var lblNavigation : UILabel!
    @IBOutlet var lblHideShow : UILabel!
    
    @IBOutlet var btnProfileEdit : UIButton!
    @IBOutlet var btnSaveAndCreateBussinesProfile : UIButton!
    @IBOutlet var btnDropdown : UIButton!

    
    @IBOutlet var imgProfile : UIImageView!
    @IBOutlet var imgHide : UIImageView!
    
    @IBOutlet fileprivate weak var SliderAgeRange : RangeSeekSlider!
    @IBOutlet fileprivate weak var SliderKm : RangeSeekSlider!
    
    @IBOutlet var tagListView : TaglistCollection!

    @IBOutlet weak var mapView: MKMapView!

    var locationManager: CLLocationManager!
    let newPin = MKPointAnnotation()
    var imagePicker = UIImagePickerController()
    
    var lat = 0.0
    var long = 0.0
    var areaRange = 0
    var MinAgeRange = 0
    var MaxAgeRange = 0
    var Gender = ""
    var isFromUpdate = false
    var isUpdateLocation = false
    var strArrHobbies = [String]()
    var strArrAllHobbies = [String]()
    var arrHobbi = NSMutableArray()
    
    var arrSocialMedia = NSMutableArray()

    let dropDownGender = DropDown()

    lazy var dropDowns: [DropDown] = {
        return [
            self.dropDownGender,
        ]
    }()
    var arrDropdown = ["Male","Female","Other"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SetupUI()
        self.viewGender.isHidden = false
        self.imgHide.image = UIImage(named: "ic_radio")
        self.lblHideShow.text = "HIDE"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if GlobalUserData.isBusinessProfileRegistered {
            btnSaveAndCreateBussinesProfile.isHidden = true
        } else {
            btnSaveAndCreateBussinesProfile.isHidden = false
        }
        self.SetUserPersonalData()
    }
    
    override func viewDidLayoutSubviews() {
        
        self.viewNavigation.addBottomShadow()
        self.viewMale.PerticularSideRoundCorners(corners: [.topLeft, .bottomLeft], radius: 5.0)
        self.viewOther.PerticularSideRoundCorners(corners: [.topRight, .bottomRight], radius: 5.0)
    }
    
    //MARK: - Private Method
    func SetupUI() {
        
        self.imagePicker.delegate = self
        
        self.SliderAgeRange.delegate = self
        self.SliderAgeRange.minValue = 0
        self.SliderAgeRange.maxValue = 100
        
        self.SliderKm.delegate = self
        self.SliderKm.minValue = 0
        self.SliderKm.maxValue = 500
        
        if isFromUpdate {
            self.SliderKm.selectedMaxValue = CGFloat(GlobalUserData.areaRange)
            self.SliderAgeRange.selectedMinValue = CGFloat(GlobalUserData.targetAudienceAgeMin)
            self.SliderAgeRange.selectedMaxValue = CGFloat(GlobalUserData.targetAudienceAgeMax)
        } else {
            self.SliderKm.selectedMaxValue = 100.0
            self.SliderAgeRange.selectedMinValue = 10.0
            self.SliderAgeRange.selectedMaxValue = 30.0
        }
        
        self.tagListView.setupTagCollection()
        self.tagListView.delegate = self
        
        self.setupDropdownGender()
    }
    
    func setupDropdownGender() {
        
        dropDownGender.backgroundColor = .white
        dropDownGender.anchorView = txtUserGender
        dropDownGender.bottomOffset = CGPoint(x: 0, y: txtUserGender.bounds.height)
        dropDownGender.dataSource = arrDropdown
        
        dropDownGender.selectionAction = {(index: Int, item: String) in
            self.txtUserGender.text = item
        }
    }
    
    func SetUserPersonalData() {
        
        if isFromUpdate {
            lblNavigation.text = "Edit Personal Profile"
            FetchUserPersonalData()
        } else {
            lblNavigation.text = "Create Personal Profile"
            self.lblKm.text = "\((Int(SliderKm.selectedMaxValue))) Km"
            lblAge.text = "\(Int(SliderAgeRange.selectedMinValue)) - \(Int(SliderAgeRange.selectedMaxValue)) Age"
            self.SetButtonUI(SelectedLbl: lblMale, SelectedView: viewMale)
            self.MinAgeRange = 10
            self.MaxAgeRange = 30
            self.areaRange = Int(SliderKm.selectedMaxValue)
            self.SetLocation()
        }
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
    
    func SetButtonUI(SelectedLbl : UILabel , SelectedView : UIView) {
        
        lblMale.textColor = UIColor.init(hexString: colors.ThemeSky)
        lblFemale.textColor = UIColor.init(hexString: colors.ThemeSky)
        lblOther.textColor = UIColor.init(hexString: colors.ThemeSky)
        
        viewMale.backgroundColor = UIColor.init(hexString: colors.ThemeLightSky)
        viewFemale.backgroundColor = UIColor.init(hexString: colors.ThemeLightSky)
        viewOther.backgroundColor = UIColor.init(hexString: colors.ThemeLightSky)
        
        SelectedLbl.textColor = .white
        SelectedView.backgroundColor = UIColor.init(hexString: colors.ThemeSky)
        
        self.Gender = SelectedLbl.text ?? "Male"
    }
    
    //MARK: - IBActions
    @IBAction func btnBackPressed(_ sender : UIButton) {
        self.isUpdateLocation = false
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSavePressed(_ sender : UIButton) {
        if isValidDetail(){
            self.isUpdateLocation = false
            self.SaveUserPersonalData(isFrom: "Save")
        }
    }
    
    @IBAction func btnSaveAndCreateProfilePressed(_ sender : UIButton) {
        if isValidDetail(){
            self.SaveUserPersonalData(isFrom: "SaveAndCreateBussinesProfile")
        }
    }
    
    @IBAction func btnMalePressed(_ sender : UIButton) {
        self.SetButtonUI(SelectedLbl: lblMale, SelectedView: viewMale)
    }
    
    @IBAction func btnFemalePressed(_ sender : UIButton) {
        self.SetButtonUI(SelectedLbl: lblFemale, SelectedView: viewFemale)
    }
    
    @IBAction func btnOtherPressed(_ sender : UIButton) {
        self.SetButtonUI(SelectedLbl: lblOther, SelectedView: viewOther)
    }
    
    @IBAction func btnHidePressed(_ sender : UIButton) {
        if self.viewGender.isHidden == false {
            self.viewGender.isHidden = true
            self.imgHide.image = UIImage(named: "ic_Show")
            self.lblHideShow.text = "SHOW"
        } else {
            self.viewGender.isHidden = false
            self.imgHide.image = UIImage(named: "ic_radio")
            self.lblHideShow.text = "HIDE"
        }
    }
    
    @IBAction func btnProfileEditPressed(_ sender : UIButton) {
        
        self.OpenGallerySheet()
    }
    
    @IBAction func sliderKmValueChanged(_ sender: UISlider) {
    }
    
    @IBAction func btnMapPressed(_ sender : UIButton) {
        self.gotoPersonalMapVCFromPersonalProfile(Lat: self.lat, Long: self.long , controller: self)
    }
    
    @IBAction func btnDropdownPressed(_ sender : UIButton) {
        self.dropDownGender.show()
    }
}

extension PersonalProfileVC : RangeSeekSliderDelegate {
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        if slider == SliderAgeRange {
            lblAge.text = "\(Int(minValue)) - \(Int(maxValue)) Age"
            self.MinAgeRange = Int(minValue)
            self.MaxAgeRange = Int(maxValue)
        } else {
            lblKm.text = "\(Int(maxValue)) Km"
            self.areaRange = Int(maxValue)
        }
    }
    
    func didStartTouches(in slider: RangeSeekSlider) {
        print("did start touches")
    }
    
    func didEndTouches(in slider: RangeSeekSlider) {
        print("did end touches")
    }
}

extension PersonalProfileVC : CLLocationManagerDelegate,MKMapViewDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        mapView.removeAnnotation(newPin)
        let center = CLLocationCoordinate2D(latitude: self.lat, longitude: self.long)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.mapView.setRegion(region, animated: true)
        newPin.coordinate = center
        mapView.addAnnotation(newPin)

        /*let location = locations.last! as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.lat = location.coordinate.latitude
        self.long = location.coordinate.longitude
        
        mapView.setRegion(region, animated: true)
        newPin.coordinate = location.coordinate
        mapView.addAnnotation(newPin)*/
    }
}

extension PersonalProfileVC : UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
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
extension PersonalProfileVC {
    
    func isValidDetail() -> Bool {
        
        if let fullname = txtFullName.text, fullname.isEmpty{
            self.view.makeToast("Please Enter FullName.")
            return false
        }
        
        if let nickName = txtNickName.text, nickName.isEmpty{
            self.view.makeToast("Please Enter NickName.")
            return false
        }
        
        if let email = txtEmail.text, email.isEmpty{
            self.view.makeToast("Please Enter Email.")
            return false
        }
        
        /*if self.lat == 0.0{
            self.view.makeToast("Please Enter latitude.")
            return false
        }
        
        if self.long == 0.0{
            self.view.makeToast("Please Enter longitude.")
            return false
        }
        
        if self.areaRange == 0{
            self.view.makeToast("Please Select areaRange.")
            return false
        }
        
        if self.Gender == ""{
            self.view.makeToast("Please Select Gender.")
            return false
        }
        
        if self.MinAgeRange == 0{
            self.view.makeToast("Please Select Minimum Age Range.")
            return false
        }
        
        if self.MaxAgeRange == 0{
            self.view.makeToast("Please Select Maximum Age Range.")
            return false
        }*/
        
        return true
    }
    
    func CreateHobbiesArray() -> NSArray{
        
        for j in 0..<strArrAllHobbies.count {
            let dict = NSMutableDictionary()
            dict.setValue(strArrAllHobbies[j], forKey : "hobby")
            arrHobbi.add(dict)
        }
        if let json = try? JSONSerialization.data(withJSONObject: arrHobbi, options: []) {
            
            do {
                let jsonData = try? JSONSerialization.jsonObject(with: json, options: []) as? NSArray
                return jsonData ?? []
            }
           /* if let content = String(data: json, encoding: String.Encoding.utf8) {
                print(content)
                return content
            }*/
        }
        return []
    }
    
    func CreateSocialMediaDict(platform : String , link : String) -> NSMutableDictionary {
        let dict = NSMutableDictionary()
        dict.setValue(platform, forKey : "platform")
        dict.setValue(link, forKey : "link")
        return dict
    }
    
    func CreateSocialMediaArray() -> NSArray{
        
        if txtInsta.text != "" {
            let dict = CreateSocialMediaDict(platform: "Instagram", link: txtInsta.text ?? "")
            arrSocialMedia.add(dict)
        }
        
        if txtFacebook.text != "" {
            let dict = CreateSocialMediaDict(platform: "Facebook", link: txtFacebook.text ?? "")
            arrSocialMedia.add(dict)
        }

        if txtTwitter.text != "" {
            let dict = CreateSocialMediaDict(platform: "Twitter", link: txtTwitter.text ?? "")
            arrSocialMedia.add(dict)
        }
        
        if txtPintrest.text != "" {
            let dict = CreateSocialMediaDict(platform: "Pinterest", link: txtPintrest.text ?? "")
            arrSocialMedia.add(dict)
        }
        
        if txtLinkedIn.text != "" {
            let dict = CreateSocialMediaDict(platform: "Linkedin", link: txtLinkedIn.text ?? "")
            arrSocialMedia.add(dict)
        }
        
        if txtYoutube.text != "" {
            let dict = CreateSocialMediaDict(platform: "Youtube", link: txtYoutube.text ?? "")
            arrSocialMedia.add(dict)
        }


        if let json = try? JSONSerialization.data(withJSONObject: arrSocialMedia, options: []) {
            
            do {
                let jsonData = try? JSONSerialization.jsonObject(with: json, options: []) as? NSArray
                return jsonData ?? []
            }

           /* if let content = String(data: json, encoding: String.Encoding.utf8) {
                print(content)
                return content
            }*/
        }
        return []
    }

    func SaveUserPersonalData(isFrom : String) {
        
        
        if (isConnectedToNetwork()) {
            
            let headers: HTTPHeaders = ["authorization" : "bearer \(GlobalUserToken.token)", "Content-Type" : "application/json"]
            
            let params:[String:Any] = ["fullName": self.txtFullName.text ?? "",
                                       "userName" : self.txtNickName.text ?? "",
                                       "nickName" : self.txtNickName.text ?? "",
                                       "emailId" : self.txtEmail.text ?? "",
                                       "longitude" : self.long,
                                       "latitude" : self.lat,
                                       "areaRange" : self.areaRange,
                                       "gender" : self.Gender.uppercased(),
                                       "targetAudienceAgeMin" : self.MinAgeRange,
                                       "targetAudienceAgeMax" : self.MaxAgeRange,
                                       "aboutUs": txtAboutus.text ?? "",
                                       "hobbies" : CreateHobbiesArray(),
                                       "socialMediaLinks" : CreateSocialMediaArray()]
            if isFromUpdate {
                APIManager.APIPatchCalling(API_URL.Url_FetchPersonalProfile, headers: headers,params: params) { (response) in
                    //print(response)
                    let data = ModelPersonalProfile.init(dic: response as? [String:Any] ?? [:])
                    GlobalUserData = data.Data
                    if data.Status == API_URL.StatusCode {
                        do {
                            let encodedData = try NSKeyedArchiver.archivedData(withRootObject: GlobalUserData, requiringSecureCoding: false)
                            Defualtss.set(encodedData, forKey: UDKey.kUserData)
                            Defualtss.synchronize()
                            self.navigationController?.popViewController(animated: true)
                        } catch {
                            print("Something went wrong.")
                        }
                    } else {
                        self.view.makeToast(data.Message)
                    }
                }
            } else {
                APIManager.APIPostCalling(API_URL.Url_CreatePersonalProfile, headers: headers,params: params) { (response) in
                    //print(response)
                    let data = ModelPersonalProfile.init(dic: response as? [String:Any] ?? [:])
                    if data.Status == API_URL.StatusCode {
                        GlobalUserData = data.Data
                        do {
                            let encodedData = try NSKeyedArchiver.archivedData(withRootObject: GlobalUserData, requiringSecureCoding: false)
                            Defualtss.set(encodedData, forKey: UDKey.kUserData)
                            if isFrom == "Save" {
                                self.gotoHomeVC()
                            } else {
                                self.gotoBussinessProfileVC(isFromUpdate: false)
                            }
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
    
    func FetchUserPersonalData() {
        
        if (isConnectedToNetwork()) {
            
            let headers: HTTPHeaders = ["authorization" : "bearer \(GlobalUserToken.token)", "Content-Type" : "application/json"]
            
            APIManager.APIGetCalling(API_URL.Url_FetchPersonalProfile, headers: headers) { (response) in
                print(response)
                let data = ModelPersonalProfile.init(dic: response as? [String:Any] ?? [:])
                if data.Status == API_URL.StatusCode {
                    
                    self.strArrHobbies.removeAll()
                    self.strArrAllHobbies.removeAll()
                    
                    self.txtAboutus.text = data.Data.aboutUs
                    self.txtFullName.text = data.Data.fullName
                    self.txtNickName.text = data.Data.nickName
                    self.txtEmail.text = data.Data.emailId
                    self.txtFacebook.text = data.Data.socialMediaLinks.filter({$0.platform == "Facebook"}).first?.link
                    self.txtInsta.text = data.Data.socialMediaLinks.filter({$0.platform == "Instagram"}).first?.link
                    self.txtTwitter.text = data.Data.socialMediaLinks.filter({$0.platform == "Twitter"}).first?.link
                    self.txtLinkedIn.text = data.Data.socialMediaLinks.filter({$0.platform == "Linkedin"}).first?.link
                    self.txtYoutube.text = data.Data.socialMediaLinks.filter({$0.platform == "Youtube"}).first?.link
                    self.txtPintrest.text = data.Data.socialMediaLinks.filter({$0.platform == "Pintrest"}).first?.link

                    self.lblKm.text = "\(data.Data.areaRange) Km"
                    self.lblAge.text = "\(data.Data.targetAudienceAgeMin) - \(data.Data.targetAudienceAgeMax) Age"
                    self.SliderKm.selectedMaxValue = CGFloat(data.Data.areaRange)
                    if data.Data.gender == "Male".uppercased() {
                        self.Gender = "Male"
                        self.SetButtonUI(SelectedLbl: self.lblMale, SelectedView: self.viewMale)
                    } else if data.Data.gender == "Female".uppercased() {
                        self.Gender = "Female"
                        self.SetButtonUI(SelectedLbl: self.lblFemale, SelectedView: self.viewFemale)
                    } else {
                        self.Gender = "Other".uppercased()
                        self.SetButtonUI(SelectedLbl: self.lblOther, SelectedView: self.viewOther)
                    }
                    self.MinAgeRange = data.Data.targetAudienceAgeMin
                    self.MaxAgeRange = data.Data.targetAudienceAgeMax
                    self.areaRange = data.Data.areaRange
                    if !self.isUpdateLocation {
                        self.lat = Double(data.Data.latitude) ?? 0.0
                        self.long = Double(data.Data.longitude) ?? 0.0
                        self.SetLocation()
                    }
                    self.strArrHobbies = data.Data.hobbies.map{$0.hobby}
                    self.strArrAllHobbies = self.strArrHobbies
                    self.tagListView.appendTag(tagNamelist: self.strArrAllHobbies)
                } else {
                    self.view.makeToast(data.Message)
                }

            }
        } else {
            self.view.makeToast("Check your network connection")
        }
    }
}

extension PersonalProfileVC : SelectedLocation {
    
    func DelegateSelectedLocation(lat: Double, long: Double) {
        self.lat = lat
        self.long = long
        self.isUpdateLocation = true
        self.SetLocation()
    }
}

extension PersonalProfileVC : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "About us" {
            textView.text = ""
        }
        
        if textView == self.txtAboutus {
            self.txtAboutus.becomeFirstResponder()
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "About us"
        }
    }
}

extension PersonalProfileVC : UITextFieldDelegate {
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if textField == txtHobbies {
            if txtHobbies.text != "" {
                self.tagListView.appendTag(tagName: txtHobbies.text ?? "")
                strArrHobbies.append(txtHobbies.text ?? "")
                txtHobbies.text = ""
                strArrAllHobbies = strArrHobbies
            }
        }
        
        return true
    }
}

extension PersonalProfileVC : TagViewDelegate {
    
    func didRemoveTag(_ indexPath: IndexPath) {
        strArrHobbies = strArrHobbies.filter({$0 != strArrAllHobbies[indexPath.item]})
        strArrAllHobbies = strArrHobbies
    }
    
    func didTaponTag(_ indexPath: IndexPath) {
        //print("Tag tapped: \(self.aryTeglist[indexPath.item])")
    }
    
}

