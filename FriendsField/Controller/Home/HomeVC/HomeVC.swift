//
//  HomeVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 17/05/22.
//

import UIKit
import JXSegmentedView

class HomeVC: UIViewController {
    
    //MARK: - Variables
    @IBOutlet weak var viewSegmentVC: UIView!
    @IBOutlet weak var viewNavigation: UIView!
    @IBOutlet var viewPopup: UIView!
    
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var btnBusiness: UIButton!
    
    @IBOutlet weak var lblUserName: UILabel!
    
    @IBOutlet weak var viewSegmentHeader : JXSegmentedView!
    var listContainerView: JXSegmentedListContainerView!
    var segmentedDataSource: JXSegmentedBaseDataSource!
    
    //self.gotoUserListMapVC()
    let chatVC = UIStoryboard.instantiateViewController(storyborad: .main,withViewClass: ChatVC.self)
    let friendVC = UIStoryboard.instantiateViewController(storyborad: .main,withViewClass: UserListMapVC.self)
    let callLogVC = UIStoryboard.instantiateViewController(storyborad: .main,withViewClass: CallLogVC.self)
    let contactListVC = UIStoryboard.instantiateViewController(storyborad: .main,withViewClass: ContactListVC.self)
    
    let dropDownMenu = DropDown()
    lazy var dropDowns: [DropDown] = {
        return [
            self.dropDownMenu
        ]
    }()
    var arrDropdownMenu = ["New Brodcast","New Group","Requests","Settings"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SetupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.setupDropdown()
        self.lblUserName.text = "Hi, \(GlobalUserData.fullName)"
        
        let isPersonalProfile = Defualtss.bool(forKey:  UDKey.ISPersonalProfileCreate)
        if !isPersonalProfile {
            AddSubViewtoParentView(parentview: self.view, subview: self.viewPopup)
        }
    }
    
    override func viewDidLayoutSubviews() {
        self.viewNavigation.addBottomShadow()
    }
    
    //MARK: - Private Method
    func SetupUI() {
        
        self.TopSliderSetUp()
    }
    
    func convertIntoJSONString(arrayObject: NSMutableArray) -> String? {
        
        do {
            let jsonData: Data = try JSONSerialization.data(withJSONObject: arrayObject, options: [])
            if  let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) {
                return jsonString as String
            }
            
        } catch let error as NSError {
            print("Array convertIntoJSON - \(error.description)")
        }
        return nil
    }
    
    func setupDropdown() {
        
        dropDownMenu.backgroundColor = .white
        dropDownMenu.anchorView = btnMenu
        dropDownMenu.bottomOffset = CGPoint(x: 0, y: btnMenu.bounds.height)
        dropDownMenu.widthDD = 140
        dropDownMenu.dataSource = arrDropdownMenu
        
        dropDownMenu.selectionAction = {(index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            if item == "New Brodcast" {
                
            } else  if item == "New Group" {
                self.gotoCreateGroupVC()
            } else  if item == "Requests" {
                self.gotoRequestVC()
            } else if item == "Settings" {
                self.gotoSettingVC()
            }
            
        }
    }
    
    func TopSliderSetUp() {
        let titles = ["Chats", "Friends" , "Calls" , "Contacts"]
        
        let dataSource = JXSegmentedTitleImageDataSource()
        dataSource.isTitleColorGradientEnabled = true
        dataSource.titles = titles
        dataSource.titleImageType = .topImage
        dataSource.itemSpacing = 0
        dataSource.itemWidth = (viewSegmentHeader.frame.size.width / 4)
        dataSource.isImageZoomEnabled = true
        dataSource.titleSelectedColor = UIColor.init(hexString: colors.ThemeSky)
        dataSource.titleNormalColor = UIColor.init(hexString: colors.SegmentGrayColor)
        dataSource.titleNormalFont = UIFont.Roboto(size: 14, weight: .Medium)
        dataSource.titleSelectedFont = UIFont.Roboto(size: 14, weight: .Medium)
        dataSource.normalImageInfos = ["ic_Chat","ic_FindFriend","ic_Calls","ic_ContactList"]
        dataSource.selectedImageInfos = ["ic_Chat_selected","ic_FindFriend_selected","ic_Calls_selected","ic_ContactList_selected"]
        dataSource.loadImageClosure = {(imageView, normalImageInfo) in
            imageView.image = UIImage(named: normalImageInfo)
        }
        self.segmentedDataSource = dataSource
        
        viewSegmentHeader.dataSource = segmentedDataSource
        viewSegmentHeader.width = self.view.frame.size.width
        viewSegmentHeader.delegate = self
        
        listContainerView = JXSegmentedListContainerView(dataSource: self)
        viewSegmentHeader.listContainer = listContainerView
        viewSegmentVC.addSubview(listContainerView)
        listContainerView.translatesAutoresizingMaskIntoConstraints = false
        listContainerView.topAnchor.constraint(equalTo: viewSegmentVC.topAnchor).isActive = true
        listContainerView.bottomAnchor.constraint(equalTo: viewSegmentVC.bottomAnchor).isActive = true
        listContainerView.leadingAnchor.constraint(equalTo: viewSegmentVC.leadingAnchor).isActive = true
        listContainerView.trailingAnchor.constraint(equalTo: viewSegmentVC.trailingAnchor).isActive = true
    }
    
    //MARK: - IBActions
    @IBAction func btnBackPressed(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnMenuPressed(_ sender : UIButton) {
        self.dropDownMenu.show()
    }
    
    @IBAction func btnProfilePressed(_ sender : UIButton) {
        if !GlobalUserData.isPersonalProfileRegistered {
            self.gotoPersonalProfileVC(isFromUpdate: false)
        } else {
            self.gotoUserProfileVC()
        }
    }
    
    @IBAction func btnBussinesPressed(_ sender : UIButton) {
        self.gotoNewProductListVC()
    }
    
    @IBAction func btnShadowPressed(_ sender : UIButton) {
        
        self.viewPopup.removeFromSuperview()
    }
    
    @IBAction func btnSkipNowPressed(_ sender : UIButton) {
        
        self.viewPopup.removeFromSuperview()
    }
    
    @IBAction func btnContinuePressed(_ sender : UIButton) {
        
        self.viewPopup.removeFromSuperview()
        self.gotoPersonalProfileVC(isFromUpdate: false)
    }
    
    @IBAction func btnclosePressed(_ sender : UIButton) {
        
        self.viewPopup.removeFromSuperview()
    }
    
    @IBAction func btnBoardCastPressed(_ sender : UIButton) {
        self.gotoPromotionBaseVC()
    }
    
    @IBAction func btnLikePressed(_ sender : UIButton) {
        
        self.gotoLikeCommentVC()
    }
    
}

extension HomeVC: JXSegmentedViewDelegate {
    
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        
    }
}

extension HomeVC: JXSegmentedListContainerViewDataSource {
    
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        if let titleDataSource = viewSegmentHeader.dataSource as? JXSegmentedBaseDataSource {
            return titleDataSource.dataSource.count
        }
        return 0
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        
        switch index {
        case 0 :
            chatVC.parentView = self
            return chatVC
        case 1 :
            return friendVC
        case 2 :
            return callLogVC
        case 3:
            return contactListVC
        default:
            return chatVC
        }
    }
}
