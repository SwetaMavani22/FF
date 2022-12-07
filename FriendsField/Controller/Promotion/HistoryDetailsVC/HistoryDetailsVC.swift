//
//  HistoryDetailsVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 21/06/22.
//

import UIKit
import BubblePictures

class HistoryDetailsVC: UIViewController {
    
    @IBOutlet var viewNavigation : UIView!
    @IBOutlet var viewPopUp : UIView!

    @IBOutlet weak var collectionBubble: UICollectionView!
    
    @IBOutlet var lblProductName : UILabel!
    @IBOutlet var lblProductDesc : UILabel!
    @IBOutlet var lblNotification : UILabel!
    @IBOutlet var lblEmail : UILabel!
    @IBOutlet var lblSMS : UILabel!
    @IBOutlet var lblPeoplesCount : UILabel!

    @IBOutlet var imgProduct : UIImageView!
    
    @IBOutlet var tblPeoples : UITableView!

    //MARK: - Variables
    var bubblePictures: BubblePictures!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SetupUI()
    }
    
    override func viewDidLayoutSubviews() {
        self.viewNavigation.addBottomShadow()
    }

    //MARK: - Private Method
    func SetupUI() {
        
       self.SetupBubbleView()
    }

    func SetupBubbleView() {
        
        let configFiles = getConfigFiles()
        let layoutConfigurator = BPLayoutConfigurator(
            backgroundColorForTruncatedBubble: UIColor.init(hexString: colors.ThemeSky),
            colorForBubbleBorders: UIColor.white,
            colorForBubbleTitles: UIColor.black,
            maxCharactersForBubbleTitles : 10,
            maxNumberOfBubbles: 5,
            displayForTruncatedCell: BPTruncatedCellDisplay.number(5),
            direction: .leftToRight,
            alignment: .center)
        
        bubblePictures = BubblePictures(collectionView: collectionBubble, configFiles: configFiles, layoutConfigurator: layoutConfigurator)
        bubblePictures.delegate = self

    }
    
    func getConfigFiles() -> [BPCellConfigFile] {
        return [
            BPCellConfigFile(
                imageType: BPImageType.URL(URL(string: "https://images.bluethumb.com.au/uploads/listing/310962/alex-frayne-silhouette-duplicate-bluethumb-7868.jpg?w=766&h=766&fit=crop&auto=compress&cs=tinysrgb&q=70&s=dff4209ba8e0ebb3e733c4a391bf9d9f")!),
                title: ""),
            BPCellConfigFile(
                imageType: BPImageType.URL(URL(string: "https://images.bluethumb.com.au/uploads/listing/310962/alex-frayne-silhouette-duplicate-bluethumb-7868.jpg?w=766&h=766&fit=crop&auto=compress&cs=tinysrgb&q=70&s=dff4209ba8e0ebb3e733c4a391bf9d9f")!),
                title: ""),
            BPCellConfigFile(
                imageType: BPImageType.URL(URL(string: "https://images.bluethumb.com.au/uploads/listing/310962/alex-frayne-silhouette-duplicate-bluethumb-7868.jpg?w=766&h=766&fit=crop&auto=compress&cs=tinysrgb&q=70&s=dff4209ba8e0ebb3e733c4a391bf9d9f")!),
                title: ""),
            BPCellConfigFile(
                imageType: BPImageType.URL(URL(string: "https://images.bluethumb.com.au/uploads/listing/310962/alex-frayne-silhouette-duplicate-bluethumb-7868.jpg?w=766&h=766&fit=crop&auto=compress&cs=tinysrgb&q=70&s=dff4209ba8e0ebb3e733c4a391bf9d9f")!),
                title: ""),
            BPCellConfigFile(
                imageType: BPImageType.URL(URL(string: "https://images.bluethumb.com.au/uploads/listing/310962/alex-frayne-silhouette-duplicate-bluethumb-7868.jpg?w=766&h=766&fit=crop&auto=compress&cs=tinysrgb&q=70&s=dff4209ba8e0ebb3e733c4a391bf9d9f")!),
                title: ""),
            BPCellConfigFile(
                imageType: BPImageType.URL(URL(string: "https://images.bluethumb.com.au/uploads/listing/310962/alex-frayne-silhouette-duplicate-bluethumb-7868.jpg?w=766&h=766&fit=crop&auto=compress&cs=tinysrgb&q=70&s=dff4209ba8e0ebb3e733c4a391bf9d9f")!),
                title: ""),

            BPCellConfigFile(
                imageType: BPImageType.URL(URL(string: "https://images.bluethumb.com.au/uploads/listing/310962/alex-frayne-silhouette-duplicate-bluethumb-7868.jpg?w=766&h=766&fit=crop&auto=compress&cs=tinysrgb&q=70&s=dff4209ba8e0ebb3e733c4a391bf9d9f")!),
                title: "")

        ]
    }
    
    //MARK: - IBActions
    @IBAction func btnBackPressed(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnClosePressed(_ sender : UIButton) {
        viewPopUp.removeFromSuperview()
    }

    @IBAction func btnShadowPressed(_ sender : UIButton) {
        viewPopUp.removeFromSuperview()
    }

    @IBAction func btnaPeoplesPressed(_ sender : UIButton) {
        AddSubViewtoParentView(parentview: self.view, subview: self.viewPopUp)
    }

}

extension HistoryDetailsVC: BPDelegate {
    func didSelectTruncatedBubble() {
        print("Selected truncated bubble")
    }
    
    func didSelectBubble(at index: Int) {
        print(index)
    }
}

extension HistoryDetailsVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tblPeoples.dequeueReusableCell(withIdentifier: "cellPeople") as? cellPeople {
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
