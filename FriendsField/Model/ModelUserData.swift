//
//  ModelUserData.swift
//  FriendsField
//
//  Created by iMac on 26/08/22.
//

import Foundation

class ModelUserData : NSObject  {
    
    var id = ""
    var contactNo = ""
    var fullName = ""
    var userName = ""
    var emailId = ""
    var nickName = ""
    var longitude = ""
    var latitude = ""
    var aboutUs = ""
    var areaRange = 0
    var gender = ""
    var targetAudienceAgeMin = 0
    var targetAudienceAgeMax = 0
    var isBusinessProfileRegistered = false
    var isPersonalProfileRegistered = false
    var active = false
    var hobbies = [ModelHobbies]()
    var socialMediaLinks = [ModelSocialMediaLinks]()

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
        aboutUs = dic["aboutUs"] as? String ?? ""
        targetAudienceAgeMin = dic["targetAudienceAgeMin"] as? Int ?? 0
        targetAudienceAgeMax = dic["targetAudienceAgeMax"] as? Int ?? 0
        isBusinessProfileRegistered = dic["isBusinessProfileRegistered"] as? Bool ?? false
        isPersonalProfileRegistered = dic["isPersonalProfileRegistered"] as? Bool ?? false
        active = dic["active"] as? Bool ?? false
        if let arr = dic["hobbies"] as? [[String:Any]] {
            hobbies = arr.map(ModelHobbies.init)
        }
        if let arr = dic["socialMediaLinks"] as? [[String:Any]] {
            socialMediaLinks = arr.map(ModelSocialMediaLinks.init)
        }
    }

}

class ModelHobbies : NSObject {
    
    var id = ""
    var hobby = ""
    var active = ""
    var createdAt = ""
    var updatedAt = ""
    var user_id = ""
    
    init(dic:[String:Any]) {
        
        id = dic["id"] as? String ?? ""
        hobby = dic["hobby"] as? String ?? ""
        active = dic["active"] as? String ?? ""
        createdAt = dic["createdAt"] as? String ?? ""
        updatedAt = dic["updatedAt"] as? String ?? ""
        user_id = dic["user_id"] as? String ?? ""
    }
}

class ModelSocialMediaLinks : NSObject {
    
    var id = ""
    var platform = ""
    var link = ""
    var active = ""
    var createdAt = ""
    var updatedAt = ""
    var user_id = ""
    
    init(dic:[String:Any]) {
        
        id = dic["id"] as? String ?? ""
        platform = dic["platform"] as? String ?? ""
        link = dic["link"] as? String ?? ""
        active = dic["active"] as? String ?? ""
        createdAt = dic["createdAt"] as? String ?? ""
        updatedAt = dic["updatedAt"] as? String ?? ""
        user_id = dic["user_id"] as? String ?? ""
    }
}

