//
//  PickerPopUpVC.swift
//  LittleLand
//
//  Created by Lead on 03/08/17.
//  Copyright © 2017 Lead. All rights reserved.
//

import UIKit

class PickerPopUpVC: UIView {
    
    @IBOutlet weak var btn_Alpha_Cancel: UIButton!
    
    @IBOutlet weak var btn_Cancel: UIButton!
    @IBOutlet weak var btn_Done: UIButton!
    
    @IBOutlet weak var view_Picker: UIView!
    @IBOutlet weak var view_Picker_Heder: UIView!
    @IBOutlet weak var picker: UIDatePicker!
    
    
    override func awakeFromNib() {
        self.openAnimation()
//        picker.setValue(UIColor.white, forKey: "textColor")
    }
    
    func openAnimation() {
        DispatchQueue.main.async {
            self.view_Picker.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width, height: 240)
            self.btn_Alpha_Cancel.alpha = 0
            UIView.animate(withDuration: 0.3) {
                self.view_Picker.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height-240, width: UIScreen.main.bounds.size.width, height: 240)
                self.btn_Alpha_Cancel.alpha = 0.7
            }
        }
    }
    
    func closeAnimation() {
        DispatchQueue.main.async {
            self.view_Picker.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height-240, width: UIScreen.main.bounds.size.width, height: 240)
            self.btn_Alpha_Cancel.alpha = 0.7
            UIView.animate(withDuration: 0.3, animations: {
                self.view_Picker.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width, height: 240)
                self.btn_Alpha_Cancel.alpha = 0
            }, completion: { (true) in
                self.removeFromSuperview()
            })
        }
    }
}
