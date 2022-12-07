//
//  ModelUserGlobalData.swift
//  FriendsField
//
//  Created by iMac on 26/08/22.
//

import Foundation

class ModelGlobalUserData : NSObject , NSCoding {
    
    var id = ""
    var contactNo = ""
    var fullName = ""
    var userName = ""
    var emailId = ""
    var nickName = ""
    var longitude = ""
    var latitude = ""
    var areaRange = 0
    var gender = ""
    var targetAudienceAgeMin = 0
    var targetAudienceAgeMax = 0
    var isBusinessProfileRegistered = false
    var isPersonalProfileRegistered = false
    var active = false

    override init() {
        super.init()
    }
    
    init(dic:[String:Any]) {
        id = dic["id"] as? String ?? ""
        contactNo = dic["contactNo"] as? String ?? ""
        fullName = dic["fullName"] as? String ?? ""
        userName = dic["userName"] as? String ?? ""
        emailId = dic["emailId"] as? String ?? ""
        nickName = dic["nickName"] as? String ?? ""
        longitude = dic["longitude"] as? String ?? ""
        latitude = dic["latitude"] as? String ?? ""
        areaRange = dic["areaRange"] as? Int ?? 0
        gender = dic["gender"] as? String ?? ""
        targetAudienceAgeMin = dic["targetAudienceAgeMin"] as? Int ?? 0
        targetAudienceAgeMax = dic["targetAudienceAgeMax"] as? Int ?? 0
        isBusinessProfileRegistered = dic["isBusinessProfileRegistered"] as? Bool ?? false
        isPersonalProfileRegistered = dic["isPersonalProfileRegistered"] as? Bool ?? false
        active = dic["active"] as? Bool ?? false
    }

    required init?(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: "id") as? String ?? ""
        contactNo = aDecoder.decodeObject(forKey: "contactNo") as? String ?? ""
        fullName = aDecoder.decodeObject(forKey: "fullName") as? String ?? ""
        userName = aDecoder.decodeObject(forKey: "userName") as? String ?? ""
        emailId = aDecoder.decodeObject(forKey: "emailId") as? String ?? ""
        nickName = aDecoder.decodeObject(forKey: "nickName") as? String ?? ""
        longitude = aDecoder.decodeObject(forKey: "longitude") as? String ?? ""
        latitude = aDecoder.decodeObject(forKey: "latitude") as? String ?? ""
        areaRange = aDecoder.decodeInteger(forKey: "areaRange")
        gender = aDecoder.decodeObject(forKey: "gender") as? String ?? ""
        targetAudienceAgeMin = aDecoder.decodeInteger(forKey: "targetAudienceAgeMin")
        targetAudienceAgeMax = aDecoder.decodeInteger(forKey: "targetAudienceAgeMax")
        isBusinessProfileRegistered = aDecoder.decodeBool(forKey: "isBusinessProfileRegistered")
        isPersonalProfileRegistered = aDecoder.decodeBool(forKey: "isPersonalProfileRegistered")
        active = aDecoder.decodeBool(forKey: "active")
                
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(contactNo, forKey: "contactNo")
        aCoder.encode(fullName, forKey: "fullName")
        aCoder.encode(userName, forKey: "userName")
        aCoder.encode(emailId, forKey: "emailId")
        aCoder.encode(nickName, forKey: "nickName")
        aCoder.encode(longitude, forKey: "longitude")
        aCoder.encode(latitude, forKey: "latitude")
        aCoder.encode(areaRange, forKey: "areaRange")
        aCoder.encode(gender, forKey: "gender")
        aCoder.encode(targetAudienceAgeMin, forKey: "targetAudienceAgeMin")
        aCoder.encode(targetAudienceAgeMax, forKey: "targetAudienceAgeMax")
        aCoder.encode(isBusinessProfileRegistered, forKey: "isBusinessProfileRegistered")
        aCoder.encode(isPersonalProfileRegistered, forKey: "isPersonalProfileRegistered")
        aCoder.encode(active, forKey: "active")
    }

}
