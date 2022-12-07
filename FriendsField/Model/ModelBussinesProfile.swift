//
//  ModelBussinesProfile.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 26/05/22.
//

import Foundation

class ModelBussinesProfile : NSObject {
    
    var Message = ""
    var IsSuccess = false
    var Status = 0
    var Data = ModelBussinesData()
    
    override init() {
        super.init()
    }
    
    init(dic:[String:Any]) {
        
        Status = dic["Status"] as? Int ?? 0
        Message = dic["Message"] as? String ?? ""
        IsSuccess = dic["IsSuccess"] as? Bool ?? false
        Data = ModelBussinesData.init(dic: dic["data"] as? [String:Any] ?? ["":""])
    }
}

class ModelBussinesData : NSObject, NSCoding {
    
    var id = ""
    var name = ""
    var category = ""
    var subCategory = ""
    var Description = ""
    var interestedCategory = ""
    var interestedSubCategory = ""
    var longitude = ""
    var latitude = ""
    var active = false

    override init() {
        super.init()
    }
    
    init(dic:[String:Any]) {
        
        id = dic["id"] as? String ?? ""
        name = dic["name"] as? String ?? ""
        category = dic["category"] as? String ?? ""
        subCategory = dic["subCategory"] as? String ?? ""
        Description = dic["description"] as? String ?? ""
        interestedCategory = dic["interestedCategory"] as? String ?? ""
        interestedSubCategory = dic["interestedSubCategory"] as? String ?? ""
        longitude = dic["longitude"] as? String ?? ""
        latitude = dic["latitude"] as? String ?? ""
        active = dic["active"] as? Bool ?? false
    }
    
    required init?(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: "id") as? String ?? ""
        name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        category = aDecoder.decodeObject(forKey: "category") as? String ?? ""
        subCategory = aDecoder.decodeObject(forKey: "subCategory") as? String ?? ""
        Description = aDecoder.decodeObject(forKey: "description") as? String ?? ""
        interestedCategory = aDecoder.decodeObject(forKey: "interestedCategory") as? String ?? ""
        interestedSubCategory = aDecoder.decodeObject(forKey: "interestedSubCategory") as? String ?? ""
        longitude = aDecoder.decodeObject(forKey: "longitude") as? String ?? ""
        latitude = aDecoder.decodeObject(forKey: "latitude") as? String ?? ""
        active = aDecoder.decodeBool(forKey: "active")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(category, forKey: "category")
        aCoder.encode(subCategory, forKey: "subCategory")
        aCoder.encode(Description, forKey: "description")
        aCoder.encode(interestedCategory, forKey: "interestedCategory")
        aCoder.encode(interestedSubCategory, forKey: "interestedSubCategory")
        aCoder.encode(longitude, forKey: "longitude")
        aCoder.encode(latitude, forKey: "latitude")
        aCoder.encode(active, forKey: "active")
    }

}

