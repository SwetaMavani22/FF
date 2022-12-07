//
//  ModelContactUS.swift
//  FriendsField
//
//  Created by iMac on 01/09/22.
//

import Foundation

class ModelContactUS : NSObject {
    
    var Message = ""
    var IsSuccess = false
    var Status = 0
    var Data = ModelContactUsData()
    
    override init() {
        super.init()
    }
    
    init(dic:[String:Any]) {
        
        Status = dic["Status"] as? Int ?? 0
        Message = dic["Message"] as? String ?? ""
        IsSuccess = dic["IsSuccess"] as? Bool ?? false
        Data = ModelContactUsData.init(dic: dic["data"] as? [String:Any] ?? ["":""])
    }
}

class ModelContactUsData : NSObject {
    
    var id = ""
    var fullName = ""
    var contactNo = ""
    var emailId = ""
    var issue = ""

    override init() {
        super.init()
    }
    
    init(dic:[String:Any]) {
        
        id = dic["id"] as? String ?? ""
        fullName = dic["fullName"] as? String ?? ""
        contactNo = dic["contactNo"] as? String ?? ""
        emailId = dic["emailId"] as? String ?? ""
        issue = dic["issue"] as? String ?? ""
    }
}
