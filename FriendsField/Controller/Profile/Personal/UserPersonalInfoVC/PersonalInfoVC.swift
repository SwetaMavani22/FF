//
//  UserPersonalInfoVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 18/05/22.
//

import UIKit
import JXSegmentedView
import Alamofire
import CoreLocation

class PersonalInfoVC: UIViewController {
    
    //MARK: - Variables
    @IBOutlet weak var lblPhoneNumber: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblAgeRange: UILabel!
    @IBOutlet weak var lblIntrest: UILabel!
    @IBOutlet weak var lblAreaRange: UILabel!
    @IBOutlet weak var lblAuboutUS: UILabel!
    
    @IBOutlet weak var switchLock : UISwitch!
    
    @IBOutlet weak var collectionHobbies : UICollectionView!
                
    var userdata = ModelUserData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SetupUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.FetchUserPersonalData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    //MARK: - Private Method
    func SetupUI() {
        
        let isISFacelock = Defualtss.bool(forKey:  UDKey.kIsFaceLock)
        switchLock.isOn = isISFacelock
    }
    
    func FetchUserPersonalData() {
        
        if (isConnectedToNetwork()) {
            
            let headers: HTTPHeaders = ["authorization" : "bearer \(GlobalUserToken.token)", "Content-Type" : "application/json"]
            
            APIManager.APIGetCalling(API_URL.Url_FetchPersonalProfile, headers: headers) { (response) in
                //print(response)
                let data = ModelPersonalProfile.init(dic: response as? [String:Any] ?? [:])
                if data.Status == API_URL.StatusCode {
                    self.userdata = data.Data
                    GlobalUserData = data.Data
                    do {
                        let encodedData = try NSKeyedArchiver.archivedData(withRootObject: GlobalUserData, requiringSecureCoding: false)
                        Defualtss.set(encodedData, forKey: UDKey.kUserData)
                        self.SetUpData(data: data.Data)
                    } catch let error {
                        print("Something went wrong. \(error.localizedDescription)")
                    }
                } else {
                    self.view.makeToast(data.Message)
                }
            }
        } else {
            self.view.makeToast("Check your network connection")
        }
    }
    
    func SetUpData(data : ModelUserData) {
        
        lblPhoneNumber.text = data.contactNo
        lblEmail.text = data.emailId
        lblAgeRange.text = "\(data.targetAudienceAgeMin) - \(data.targetAudienceAgeMax)"
        lblIntrest.text = data.gender
        lblAreaRange.text = "\(data.areaRange) Km"
        lblAuboutUS.text = data.aboutUs
        let lat = Double(data.latitude) ?? 0.0
        let long = Double(data.longitude) ?? 0.0
        GetAddress(Lat: lat, Long: long, completion: { (ADDRESS) in
            self.lblLocation.text = ADDRESS
        })
        collectionHobbies.reloadData()
    }
    
    //MARK: - IBActions
    @IBAction func btnBackPressed(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
       
    @IBAction func switchFaceLockPressed(_ sender : UISwitch) {
        if sender.isOn {
            Defualtss.set(true, forKey: UDKey.kIsFaceLock)
        } else {
            Defualtss.set(false, forKey: UDKey.kIsFaceLock)
        }
    }

}

extension PersonalInfoVC: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}

extension PersonalInfoVC : TagViewDelegate {
    
    func didRemoveTag(_ indexPath: IndexPath) {
    }
    
    func didTaponTag(_ indexPath: IndexPath) {
        //print("Tag tapped: \(self.aryTeglist[indexPath.item])")
    }
    
}

extension PersonalInfoVC : UICollectionViewDelegateFlowLayout , UICollectionViewDelegate ,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userdata.hobbies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionHobbies.dequeueReusableCell(withReuseIdentifier: "cellHobbiesList", for: indexPath) as? cellHobbiesList {
            
            cell.lblHobbies.text = "\(userdata.hobbies[indexPath.row].hobby)"
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    
}

class cellHobbiesList : UICollectionViewCell {
    
    @IBOutlet weak var lblHobbies : UILabel!
}
