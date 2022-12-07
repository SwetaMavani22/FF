//
//  UIStoryBorad+Ext.swift
//  mExpense Firebase
//
//  Created by Heena's Mac on 30/12/19.
//  Copyright © 2019 Viprak. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
        
    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }

    class func instantiateViewController<T: UIViewController>(storyborad:UIStoryboard,withViewClass: T.Type) -> T {
        return storyborad.instantiateViewController(withIdentifier: String(describing: withViewClass.self)) as! T
    }
}

extension Notification.Name {
    static let didReceiveNotifictaion = Notification.Name("receiveNotifictaion")
}
