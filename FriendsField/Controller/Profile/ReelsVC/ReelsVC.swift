//
//  ReelsVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 17/06/22.
//

import UIKit
import JXSegmentedView

class ReelsVC: UIViewController {
    
    //MARK: - Variables
    @IBOutlet var collectionReels : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SetupUI()
    }
    
    //MARK: - Private Method
    func SetupUI() {
        
    }
    
    //MARK: - IBActions
    @IBAction func btnBackPressed(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ReelsVC : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let index = indexPath.row + 1
        if (index % 8 == 0 && indexPath.row != 0) {
            if let cell = collectionReels.dequeueReusableCell(withReuseIdentifier: "cellReelAds", for: indexPath) as? cellReelAds {
                
                return cell
            }
        } else {
            if let cell = collectionReels.dequeueReusableCell(withReuseIdentifier: "cellReels", for: indexPath) as? cellReels {
                
                return cell
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionReels.frame.size.width/3) - 5, height: 130)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

extension ReelsVC: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}

