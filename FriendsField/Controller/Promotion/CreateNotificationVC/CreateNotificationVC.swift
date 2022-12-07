//
//  CreateNotificationVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 18/06/22.
//

import UIKit

class CreateNotificationVC: UIViewController {
    
    //MARK: - Variables
    @IBOutlet var lbltxtCount : UILabel!
    
    @IBOutlet var txtTitle : UITextField!
    @IBOutlet var txtLink : UITextField!
    @IBOutlet var txtViewDesc : UITextView!
    
    @IBOutlet var imgNotification : UIImageView!
    
    @IBOutlet var btnEditImage : UIButton!
    @IBOutlet var btnUploadImage : UIButton!
    
    @IBOutlet var viewNavigation : UIView!
    
    var imagePicker = UIImagePickerController()

    var isUpdate = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SetupUI()
    }

    override func viewDidLayoutSubviews() {
        self.viewNavigation.addBottomShadow()
    }

    //MARK: - Private Method
    func SetupUI() {
        self.imagePicker.delegate = self
    }
    
    //MARK: - IBActions
    @IBAction func btnBackPressed(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnDonePressed(_ sender : UIButton) {
    }

    @IBAction func btnUploadImagePressed(_ sender : UIButton) {
        self.OpenGallerySheet()
    }

    @IBAction func btnEditImagePressed(_ sender : UIButton) {
        self.OpenGallerySheet()
    }

}

extension CreateNotificationVC : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Notification Description" {
            textView.text = ""
        }
        
        if textView == self.txtViewDesc {
            self.txtViewDesc.becomeFirstResponder()
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Notification Description"
        }
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        lbltxtCount.text = "\(newText.count)/150"
        return numberOfChars < 150    // 10 Limit Value
    }

}

extension CreateNotificationVC : UITextFieldDelegate {
    
}

extension CreateNotificationVC : UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
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
            alert.popoverPresentationController?.sourceView = btnEditImage
            alert.popoverPresentationController?.sourceRect = btnEditImage.bounds
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
            imgNotification.image = chosenImage
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}
