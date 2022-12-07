//
//  Date+Ext.swift
//  GST
//
//  Created by user1 on 01/02/22.
//

import Foundation

extension Date {
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
