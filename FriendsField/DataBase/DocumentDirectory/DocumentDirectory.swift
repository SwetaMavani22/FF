//
//  DocumentDirectory.swift
//  StarCall
//
//  Created by Techno Exponent on 02/05/22.
//  Copyright © 2022 Techno Exponent. All rights reserved.
//

import Foundation
import UIKit

class DocumentDirectory : NSObject {
    
    func SaveImage(fileName : String , image : UIImage) {
        
        do {
            let documentsDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            print("documentsDirectory:", documentsDirectory.path)
            let fileURL = documentsDirectory.appendingPathComponent(fileName)
            if let data = image.jpegData(compressionQuality:  0.1),
               !FileManager.default.fileExists(atPath: fileURL.path) {
                try data.write(to: fileURL)
                print("file saved : \(fileURL)")
            }
        } catch {
            print("error:", error)
        }
    }
    
    func fetchImage(fileName : String) -> UIImage {
        
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
        let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if let dirPath  = paths.first {
            let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
            let image    = UIImage(contentsOfFile: imageURL.path)
            return image ?? UIImage()
        }
        return UIImage()
    }
    
    func deleteImage(fileName:String) {
        let filemanager = FileManager.default
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask,true)[0] as NSString
        let destinationPath = documentsPath.appendingPathComponent(fileName)
        do {
            try filemanager.removeItem(atPath: destinationPath)
            print("\n\n Local path removed successfully \n\n")
        } catch let error as NSError {
            print("------Error",error.debugDescription)
        }
    }

    func SaveVideo(videoData : NSData , videoName : String) {
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask,true)[0] as NSString
        let destinationPath = documentsPath.appendingPathComponent(videoName)
        videoData.write(toFile: destinationPath, atomically: false)
        print("\n\n Video Destination : \(destinationPath) \n\n")
    }
    
    func GetVideo(videoName : String) -> String {
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask,true)[0] as NSString
        let destinationPath = documentsPath.appendingPathComponent(videoName)
        return destinationPath
    }
    
    func CheckVideoExist(videoName : String) -> Bool {
     
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        if let pathComponent = url.appendingPathComponent(videoName) {
            let filePath = pathComponent.path
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: filePath) {
                return true
            } else {
               return false
            }
        } else {
            return false
        }
    }
    
    func SavePDF(pdfData : NSData , pdfName : String) {
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask,true)[0] as NSString
        let destinationPath = documentsPath.appendingPathComponent(pdfName)
        pdfData.write(toFile: destinationPath, atomically: false)
        print("\n\n ------- PDF Destination : \(destinationPath) \n\n")
    }
    
    func GetPDF(pdfName : String) -> String {
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask,true)[0] as NSString
        let destinationPath = documentsPath.appendingPathComponent(pdfName)
        return destinationPath
    }

}
