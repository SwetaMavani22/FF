//
//  String+Ext.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 23/05/22.
//

import Foundation
import UIKit

extension String {
    func firstLetter() -> String {
        
        guard let firstChar = self.replacingOccurrences(of: " ", with: "").first else {
            return ""
        }
        return String(firstChar)
    }
    
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat? {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.height)
    }
}
