//
//  Bucket.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 01/06/22.
//

import Foundation
import AWSS3

class SCService: NSObject {
    
    func uploadImage(fileName:String,fileToUpload:Data,contentType:String, completion: @escaping (Bool?,String?,String?)->()) {
        
        let transferManager = AWSS3TransferUtility.default()
        
        let expression:AWSS3TransferUtilityUploadExpression = AWSS3TransferUtilityUploadExpression()
        expression.setValue("public-read", forRequestParameter: "x-amz-acl")
        expression.setValue("public-read", forRequestHeader: "x-amz-acl" )
        expression.progressBlock = {(task, awsProgress) in
            
            DispatchQueue.main.async {
                //lbl.text   = "HELLO"
                print(awsProgress.fractionCompleted)
                let pr = Int(awsProgress.fractionCompleted * 100.00)
                print("awsProgress.fractionCompleted:  \(pr)")
                //lbl.text = "\(pr)%"
            }
        }
        
        transferManager.uploadData(fileToUpload, bucket: "doctors-appointment", key: "uploads/profileimage/" + fileName, contentType: contentType, expression: expression) { (task : AnyObject , error) in
            debugPrint(task)
            
            if task.error! != nil {
                debugPrint("Upload failed (\(error!.localizedDescription))")
                completion(false,nil,nil)
            }
            else
            {
                let s3URL = "https://doctors-appointment.s3-ap-southeast-2.amazonaws.com/uploads/profileimage/\(fileName)"
                debugPrint("Uploaded to:\n\(s3URL)")
                completion(true,s3URL,fileName)
            }
        }
    }
}
