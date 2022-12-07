//
//  ModelPersonalProfile.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 25/05/22.
//

import Foundation

class ModelPersonalProfile : NSObject {
    
    var Message = ""
    var IsSuccess = false
    var Status = 0
    var Data = ModelUserData()
    
    override init() {
        super.init()
    }
    
    init(dic:[String:Any]) {
        
        Status = dic["Status"] as? Int ?? 0
        Message = dic["Message"] as? String ?? ""
        IsSuccess = dic["IsSuccess"] as? Bool ?? false
        Data = ModelUserData.init(dic: dic["data"] as? [String:Any] ?? ["":""])
    }
}


