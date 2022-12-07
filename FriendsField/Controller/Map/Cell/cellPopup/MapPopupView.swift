//
//  ArtistCalloutAccessoryView.swift
//  Smilee
//
//  Created by Ashvin Gudaliya on 09/06/21.
//

import UIKit

class MapPopupView: UIView {
           
    //var thumbnail: HomeThumnails?
    @IBOutlet var lblName : UILabel!
    @IBOutlet var lblCount : UILabel!

    @IBOutlet var txtview : UITextView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

    func setup() {
        
        guard let nibView = loadViewFromNib() else {
            return
        }
                
        backgroundColor = UIColor.clear

        bounds = nibView.frame
        addSubview(nibView)
        
        //self.moreButtton.cornerRadius = self.moreButtton.frame.height / 2.0
        //moreButtton.backgroundColor = UIColor.appLightGrayF5F5F5
        
        SetData()
    }
    
    func SetData() {
       /* let data = thumbnail ?? HomeThumnails()
        eventPurchaseTypeLbl.font = UIFont.PoppinsFont(size: 10, weight: .Light)
        eventPurchaseTypeView.cornerRadius = 2

        if data.is_paid ?? 0 == 1{
            eventPurchaseTypeLbl.text = "PAID"
            eventPurchaseTypeView.backgroundColor = EventPurchaseTypes.premium.color
        }else{
            eventPurchaseTypeLbl.text = "FREE"
            eventPurchaseTypeView.backgroundColor = EventPurchaseTypes.free.color
        }
        
        usernameLbl.text = "\(data.user_name ?? "")"
        usernameLbl.font = UIFont.PoppinsFont(size: 14, weight: .SemiBold)
        
        eventViewCountLbl.text = data.formatted_viewer_count ?? ""//"231"
        eventViewCountLbl.font = UIFont.PoppinsFont(size: 10, weight: .Light)
        
        eventTypeLbl.text = data.channel_name ?? ""//"MOTIVATION"
        eventTypeLbl.font = UIFont.PoppinsFont(size: 8, weight: .LightItalic)
        
        //userImageView.cornerRadius = 17
        userImageView.round()
        userImageView.setImage(url: data.user_image ?? "")
        eventViewImageView.tintColor = UIColor.black
        eventViewImageView.image = UIImage(named: "ic_home_view")?.withRenderingMode(.alwaysTemplate)
        eventTypeView.layer.cornerRadius = 4*/

    }
        
    func loadViewFromNib() -> UIView! {
        let bundle = Bundle(for: type(of: self))
        let name =  "MapPopupView"
        let nib = UINib(nibName: name, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    //MARK: - Actions
    @IBAction func btnSubmitRequestPressed(_ sender : UIButton) {
        
        self.makeToast(txtview.text)
    }
}

extension MapPopupView : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Type Message Here..." {
            textView.text = ""
        }
        
        if textView == self.txtview {
            self.txtview.becomeFirstResponder()
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Type Message Here..."
        }
    }

}
