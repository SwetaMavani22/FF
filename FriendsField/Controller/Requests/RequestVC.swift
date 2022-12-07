//
//  RequestVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 20/05/22.
//

import UIKit
import JXSegmentedView

class RequestVC: UIViewController {
    
    //MARK: - Variables
    @IBOutlet weak var viewSegmentVC: UIView!
    @IBOutlet var viewNavigation : UIView!

    @IBOutlet weak var viewSegmentHeader : JXSegmentedView!
    var listContainerView: JXSegmentedListContainerView!
    var segmentedDataSource: JXSegmentedBaseDataSource!

    let friendRequestVC = UIStoryboard.instantiateViewController(storyborad: .main,withViewClass: FriendRequestVC.self)
    let sendRequestVC = UIStoryboard.instantiateViewController(storyborad: .main,withViewClass: SendRequestVC.self)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SetupUI()
    }

    override func viewDidLayoutSubviews() {
        self.viewNavigation.addBottomShadow()
    }

    //MARK: - Private Method
    func SetupUI() {
        
        self.TopSliderSetUp()
    }
    
    func TopSliderSetUp() {
        let titles = ["FRIEND REQUEST" , "SEND REQUEST"]
        let dataSource = JXSegmentedTitleDataSource()
        dataSource.isItemSpacingAverageEnabled = true
        dataSource.itemWidth = (viewSegmentHeader.frame.size.width / 2) - 20
        dataSource.titles = titles
        dataSource.titleNormalFont = UIFont.Roboto(size: 14, weight: .Bold)
        dataSource.titleSelectedFont = UIFont.Roboto(size: 14, weight: .Bold)
        dataSource.titleSelectedColor = UIColor.init(hexString: colors.ThemeSky)
        dataSource.titleNormalColor = UIColor.black.withAlphaComponent(1)
        self.segmentedDataSource = dataSource
        
        let indicator = JXSegmentedIndicatorBackgroundView()
        indicator.indicatorHeight = 40
        indicator.indicatorCornerRadius = 5
        indicator.indicatorColor = UIColor.white
        self.viewSegmentHeader.indicators = [indicator]
        viewSegmentHeader.backgroundColor = UIColor.init(hexString: colors.ThemeGray)
        viewSegmentHeader.dataSource = segmentedDataSource
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
}

extension RequestVC: JXSegmentedViewDelegate {
    
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {

    }
}

extension RequestVC: JXSegmentedListContainerViewDataSource {
    
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        if let titleDataSource = viewSegmentHeader.dataSource as? JXSegmentedBaseDataSource {
            return titleDataSource.dataSource.count
        }
        return 0
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        
        switch index {
        case 0 :
            friendRequestVC.ParentView = self.view
            return friendRequestVC
        case 1 :
            return sendRequestVC
        default:
            friendRequestVC.ParentView = self.view
            return friendRequestVC
        }
    }
}
