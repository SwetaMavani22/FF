//
//  MessageVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 21/05/22.
//

import UIKit

class MessageVC: UIViewController {
    
    //MARK: - Variables
    @IBOutlet var viewNavigation : UIView!
    @IBOutlet var viewMessage : UIView!
    @IBOutlet var viewBusinessMessage : UIView!
    
    @IBOutlet var lblProductName : UILabel!
    @IBOutlet var lblProductDesc : UILabel!
    @IBOutlet var lblProductPrice : UILabel!
    
    @IBOutlet var imgProduct : UIImageView!

    @IBOutlet weak var txtMessage: EmojiTextView!
    @IBOutlet weak var txtBusinessMessage: EmojiTextView!

    @IBOutlet weak var constrainMessageHeight: NSLayoutConstraint!
    @IBOutlet weak var constrainBusinessMessageHeight: NSLayoutConstraint!

    @IBOutlet var tblMessage : UITableView!
    
    var arrMessage = [String]()
    var arrImages = [String]()
    
    let refreshControl = UIRefreshControl()
    var imagePicker : UIImagePickerController = UIImagePickerController()
    var selectedImage = UIImage()
    
    var MessageType = ""
    
    var isFromInquiry = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SetUpTableView()
        SocketHelper.shared.socket?.connect()
    }
    
    override func viewDidLayoutSubviews() {
        self.viewNavigation.addBottomShadow()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.SetupUI()
    }
    
    //MARK: - Private Method
    func SetupUI() {
        
        if isFromInquiry {
            viewBusinessMessage.isHidden = false
            viewMessage.isHidden = true
        } else {
            viewBusinessMessage.isHidden = true
            viewMessage.isHidden = false
        }

        MessageType = MsgType.Text
        arrMessage = ["There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected.","There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected.","There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected.","There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected.","There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected.","There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected.","There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected.","There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected."]
        
        self.tblMessage.reloadData {
            self.tblMessage.scrollToBottomRow()
        }
    }
    
    func SetUpTableView() {
        
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tblMessage.addSubview(refreshControl)
        tblMessage.delegate = self
        tblMessage.dataSource = self
        tblMessage.rowHeight = UITableView.automaticDimension
        
        //Sender...
        tblMessage.register(with: Cell.sendMsgCell)
        tblMessage.register(with: Cell.chatSendImageCell)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        refreshControl.endRefreshing()
    }
    
    func OpenGallery() {
        self.imagePicker.sourceType = .photoLibrary
        self.imagePicker.delegate = self
        self.imagePicker.mediaTypes = ["public.image", "public.movie"]
        DispatchQueue.main.async {
            self.present(self.imagePicker, animated: true, completion: nil)
        }
    }
    
    func OpenCamera() {
        self.imagePicker.sourceType = .camera
        self.imagePicker.delegate = self
        self.imagePicker.mediaTypes = ["public.image"]
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    //MARK: - IBActions
    @IBAction func btnBackPressed(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAudioCallPressed(_ sender : UIButton) {
        self.gotoAudioCallVC()
    }
    
    @IBAction func btnVideoCallPressed(_ sender : UIButton) {
        self.gotoVideoCallVC()
    }
    
    @IBAction func btnSendMessagePressed(_ sender : UIButton) {
        
        if txtMessage.text == "" || txtMessage.text == "Typing here..." {
            self.view.makeToast("Please Enter Message..")
        } else {
            constrainMessageHeight.constant = 60
            if MessageType == MsgType.Text {
                self.arrMessage.append(txtMessage.text)
                
                SocketHelper.shared.joinChatRoom(nickname: txtMessage.text, completion: { [weak self] in
                    
                    guard let nickName = txtMessage.text,
                        let self = self else{
                            return
                    }
                    print(nickName)
                })
                /*SocketHelper.shared.socket?.on(clientEvent: .connect) { (data, ack) in
                    print("socket connected")
                    SocketHelper.shared.sendMessage(message: self.txtMessage.text, withNickname: "name")
                }*/

                self.txtMessage.text = ""
            }
            /*else if MessageType == MsgType.Image{
             let s_Name = "fileImg"
             let uuid = UUID().uuidString
             let f_Name = "\(s_Name)_\(uuid)"
             let fileName: String = f_Name + (".png")
             let fileUrl = URL(fileURLWithPath: fileName)
             print("---------- \(fileUrl) ----------")
             arrImages.append(fileName)
             DocumentDirectory().SaveImage(fileName: fileName, image: selectedImage)
             }*/
            self.tblMessage.reloadData {
                self.tblMessage.scrollToBottomRow()
            }
        }
    }
    
    @IBAction func btnSendBussinessMessagePressed(_ sender : UIButton) {
        
    }
    
    @IBAction func btnEmojiPressed(_ sender : UIButton) {
        
    }
    
    @IBAction func btnClosePressed(_ sender : UIButton) {
        viewBusinessMessage.isHidden = true
        viewMessage.isHidden = false
    }

    @IBAction func btnCameraPressed(_ sender : UIButton) {
        self.OpenCamera()
    }
    
    @IBAction func btnGalleryPressed(_ sender : UIButton) {
        self.OpenGallery()
    }
    
    @IBAction func btnProfilePressed(_ sender : UIButton) {
        self.gotoOtherUserProfileVC()
    }
    
}

extension MessageVC : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Typing here..." {
            textView.text = ""
        }
        
        if textView == self.txtMessage {
            self.txtMessage.becomeFirstResponder()
        }
        
        if textView == self.txtBusinessMessage {
            self.txtBusinessMessage.becomeFirstResponder()
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Typing here..."
        }
        MessageType = MsgType.Text
        txtMessage.hasEmoji = false
        txtBusinessMessage.hasEmoji = false
        constrainMessageHeight.constant = 60
        constrainBusinessMessageHeight.constant = 135
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView == txtMessage, let txt = textView.text, let font = textView.font, var height = (txt + text).heightWithConstrainedWidth(width: textView.bounds.width, font: font) {
            height += 20
            if height > 60, height < 140 {
                constrainMessageHeight.constant = height
            } else if height <= 50 {
                constrainMessageHeight.constant = 60
            }
            self.tblMessage.scrollToBottomRow()
        }
        
        if textView == txtBusinessMessage, let txt = textView.text, let font = textView.font, var height = (txt + text).heightWithConstrainedWidth(width: textView.bounds.width, font: font) {
            height += 20
            if height > 135, height < 215 {
                constrainBusinessMessageHeight.constant = height
            } else if height <= 130 {
                constrainBusinessMessageHeight.constant = 135
            }
            self.tblMessage.scrollToBottomRow()
        }
        return true
    }
}

extension MessageVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if MessageType == MsgType.Text {
            return arrMessage.count
        } else {
            return arrImages.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        ///Sender Flow...
        if MessageType == MsgType.Text {
            if let cell = tblMessage.dequeueReusableCell(withIdentifier: Cell.sendMsgCell, for: indexPath) as? SenderMsgCell {
             cell.prepareUI()
             cell.lblMessage?.text = arrMessage[indexPath.row]
             return cell
             }
        } else {
            if let cell = tblMessage.dequeueReusableCell(withIdentifier: Cell.chatSendImageCell, for: indexPath) as? ChatImageCell {
                //cell?.taleVW = chatTableView
                cell.SetupImageFromUrl(url_Str: arrImages[indexPath.row])
                return cell
            }
        }
        
        return UITableViewCell()
    }
}

extension MessageVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let chosenImage = info[.originalImage] as? UIImage{
            selectedImage = chosenImage
        }
        self.dismiss(animated: true, completion: nil)
        MessageType = MsgType.Image
        if MessageType == MsgType.Image{
            let s_Name = "fileImg"
            let uuid = UUID().uuidString
            let f_Name = "\(s_Name)_\(uuid)"
            let fileName: String = f_Name + (".png")
            let fileUrl = URL(fileURLWithPath: fileName)
            print("---------- \(fileUrl) ----------")
            arrImages.append(fileName)
            DocumentDirectory().SaveImage(fileName: fileName, image: selectedImage)
        }
        self.tblMessage.reloadData {
            self.tblMessage.scrollToBottomRow()
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}
