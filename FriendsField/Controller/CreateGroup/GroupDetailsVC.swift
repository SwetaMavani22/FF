//
//  GroupDetailsVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 16/06/22.
//

import UIKit

class GroupDetailsVC: UIViewController {
    
    @IBOutlet var collectionSelectedMember : UICollectionView!

    @IBOutlet var txtGroupName : UITextField!
    @IBOutlet var txtViewDesc : UITextView!
    
    @IBOutlet var lblParticipants : UILabel!
    
    @IBOutlet var imgGroup : UIImageView!
    
    @IBOutlet var btnImageGroup : UIButton!

    //MARK: - Variables
    var arrSelectedUser = [String]()
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SetupUI()
    }

    //MARK: - Private Method
    func SetupUI() {
     
        lblParticipants.text = "Participants: \(arrSelectedUser.count)"
    }
    
    //MARK: - IBActions
    @IBAction func btnBackPressed(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnDonePressed(_ sender : UIButton) {
    }
    
    @IBAction func btnGalleryPressed(_ sender : UIButton) {
        self.OpenGallerySheet()
    }

}

extension GroupDetailsVC : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.lblParticipants.text = "Participants: \(arrSelectedUser.count)"
        return arrSelectedUser.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionSelectedMember.dequeueReusableCell(withReuseIdentifier: "cellSelectedMembers", for: indexPath) as? cellSelectedMembers {
            
            cell.lblUserName.text = arrSelectedUser[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        arrSelectedUser.remove(at: indexPath.row)
        collectionSelectedMember.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView.numberOfItems(inSection: section) == 1 {

             let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: collectionView.frame.width - flowLayout.itemSize.width)

        }

        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension GroupDetailsVC : UITextFieldDelegate {
    
}

extension GroupDetailsVC : UITextViewDelegate {
    
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

extension GroupDetailsVC : UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
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
            alert.popoverPresentationController?.sourceView = btnImageGroup
            alert.popoverPresentationController?.sourceRect = btnImageGroup.bounds
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
           imgGroup.image = chosenImage
        }
        self.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }

}
