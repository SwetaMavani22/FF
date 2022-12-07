//
//  ModelProduct.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 26/05/22.
//

import Foundation

class ModelProductData : NSObject {
    
    var Message = ""
    var IsSuccess = false
    var Status = 0
    var Data = [ModelProductList]()
    
    override init() {
        super.init()
    }
    
    init(dic:[String:Any]) {
        
        Status = dic["Status"] as? Int ?? 0
        Message = dic["Message"] as? String ?? ""
        IsSuccess = dic["IsSuccess"] as? Bool ?? false
        if let arr = dic["Data"] as? [[String:Any]] {
            Data = arr.map(ModelProductList.init)
        }
    }
}

class ModelProductList : NSObject {
    
    var id = ""
    var name = ""
    var Description = ""
    var category = ""
    var subCategory = ""
    var offer = ""
    var itemCode = ""
    var price = ""

    override init() {
        super.init()
    }
    
    init(dic:[String:Any]) {
        
        id = dic["id"] as? String ?? ""
        name = dic["name"] as? String ?? ""
        Description = dic["description"] as? String ?? ""
        category = dic["category"] as? String ?? ""
        subCategory = dic["subCategory"] as? String ?? ""
        offer = dic["offer"] as? String ?? ""
        itemCode = dic["itemCode"] as? String ?? ""
        price = dic["price"] as? String ?? ""
    }
}
