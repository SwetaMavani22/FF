//
//  GlobalFunctions.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 18/05/22.
//

import Foundation
import UIKit
import CoreLocation

func SetRootController(WINDOW : UIWindow) {
    
    if let data = Defualtss.data(forKey:  UDKey.kUserData) {
        do {
            if let userdata = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? ModelUserData {
                GlobalUserData = userdata
                if GlobalUserData.active {
                    if let tokendata = Defualtss.data(forKey:  UDKey.kUserToken) {
                        do {
                            if let tokendata = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(tokendata) as? ModelTokenData {
                                GlobalUserToken = tokendata
                            }
                        } catch {}
                    }
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    if let vc = storyboard.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC {
                        let Nav:UINavigationController = UINavigationController(rootViewController: vc)
                        Nav.navigationBar.isHidden = true
                        Nav.interactivePopGestureRecognizer?.isEnabled = false
                        WINDOW.rootViewController = Nav
                        WINDOW.makeKeyAndVisible()
                    }
                } else {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    if let vc = storyboard.instantiateViewController(withIdentifier: "OtpsendVC") as? OtpsendVC {
                        let Nav:UINavigationController = UINavigationController(rootViewController: vc)
                        Nav.navigationBar.isHidden = true
                        Nav.interactivePopGestureRecognizer?.isEnabled = false
                        WINDOW.rootViewController = Nav
                        WINDOW.makeKeyAndVisible()
                    }
                }
            }
        } catch {
            print("Something went wrong.")
        }
    }  else {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "OtpsendVC") as? OtpsendVC {
            let Nav:UINavigationController = UINavigationController(rootViewController: vc)
            Nav.navigationBar.isHidden = true
            Nav.interactivePopGestureRecognizer?.isEnabled = false
            WINDOW.rootViewController = Nav
            WINDOW.makeKeyAndVisible()
        }
    }
}


func UserDefaultsCheck() {
    
    if Defualtss.value(forKey: UDKey.kIsFaceLock) == nil {
        Defualtss.set(false, forKey: UDKey.kIsFaceLock)
    } else {
        let isISFacelock = Defualtss.bool(forKey:  UDKey.kIsFaceLock)
        Defualtss.set(isISFacelock, forKey: UDKey.kIsFaceLock)
    }
    
    if Defualtss.value(forKey: UDKey.ISPersonalProfileCreate) == nil {
        Defualtss.set(false, forKey: UDKey.ISPersonalProfileCreate)
    } else {
        let isISFacelock = Defualtss.bool(forKey:  UDKey.ISPersonalProfileCreate)
        Defualtss.set(isISFacelock, forKey: UDKey.ISPersonalProfileCreate)
    }

    if Defualtss.value(forKey: UDKey.ISBussinesProfileCreate) == nil {
        Defualtss.set(false, forKey: UDKey.ISBussinesProfileCreate)
    } else {
        let isISFacelock = Defualtss.bool(forKey:  UDKey.ISBussinesProfileCreate)
        Defualtss.set(isISFacelock, forKey: UDKey.ISBussinesProfileCreate)
    }

 }
