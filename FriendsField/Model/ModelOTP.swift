//
//  ModelOTP.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 24/05/22.
//

import Foundation

var GlobalUserData = ModelUserData()
var GlobalUserToken = ModelTokenData()
var GlobalBussinesData = ModelBussinesData()

//MARK: - Send OTP
class ModelSendOTP : NSObject {
    
    var Message = ""
    var IsSuccess = false
    var Status = 0
    var Data = ModelSendOTPData()
    
    override init() {
        super.init()
    }
    
    init(dic:[String:Any]) {
        
        Status = dic["Status"] as? Int ?? 0
        Message = dic["Message"] as? String ?? ""
        IsSuccess = dic["IsSuccess"] as? Bool ?? false
        Data = ModelSendOTPData.init(dic: dic["Data"] as? [String:Any] ?? ["":""])
    }
}

class ModelSendOTPData : NSObject {
    
    var token = ""

    override init() {
        super.init()
    }

    init(dic:[String:Any]) {
        
        token = dic["token"] as? String ?? ""
    }
}

//MARK: - Verify OTP
class ModelVerifyOTP : NSObject {
    
    var Message = ""
    var IsSuccess = false
    var Status = 0
    var Data = ModelVerifyOTPData()

    override init() {
        super.init()
    }
    
    init(dic:[String:Any]) {
        
        Status = dic["Status"] as? Int ?? 0
        Message = dic["Message"] as? String ?? ""
        IsSuccess = dic["IsSuccess"] as? Bool ?? false
        Data = ModelVerifyOTPData.init(dic: dic["Data"] as? [String:Any] ?? ["":""])
    }
}

class ModelVerifyOTPData : NSObject {
    
    var token = ModelTokenData()
    
    override init() {
        super.init()
    }
    
    init(dic:[String:Any]) {
        
        token = ModelTokenData.init(dic: dic["token"] as? [String:Any] ?? ["":""])
    }
}

class ModelTokenData : NSObject , NSCoding {
    
    var token = ""
    
    override init() {
        super.init()
    }
    
    init(dic:[String:Any]) {
        token = dic["token"] as? String ?? ""
    }
    
    required init?(coder aDecoder: NSCoder) {
        token = aDecoder.decodeObject(forKey: "token") as? String ?? ""
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(token, forKey: "token")
    }

}

