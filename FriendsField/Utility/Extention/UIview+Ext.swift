//
//  UIview+Ext.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 16/05/22.
//

import Foundation
import UIKit

extension UIView {
    
    func addBottomShadow() {
        
        layer.masksToBounds = false
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.8
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0 , height: 2)
        layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,y: bounds.maxY - layer.shadowRadius,width: bounds.width,height: layer.shadowRadius)).cgPath
    }
    
    func roundCorners(corners: CACornerMask, radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = corners
    }

    func roundAllCorners(of radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func addBorder(ofWidth: CGFloat, color: UIColor) {
        self.layer.borderWidth = ofWidth
        self.layer.borderColor = color.cgColor
    }

    func showWithAnimation(duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.isHidden = false
        }
    }

    func hideWithAnimation(duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.isHidden = true
        }
    }

    func changeColorWithAnimation(for duration: TimeInterval, with customColor: UIColor) {
        UIView.animate(withDuration: duration) {
            self.backgroundColor = customColor
        }
    }
}
