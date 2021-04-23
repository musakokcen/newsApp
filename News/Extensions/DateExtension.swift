//
//  DateExtension.swift
//  News
//
//  Created by Musa Kokcen on 16.03.2021.
//

import Foundation

extension Date {
    class Format {
        public static var clockYearDisplay: String = "HH:mm:ss - MMM dd, yyyy"
        public static var yyyy_MM_dd_T_HH_mm_ssZ = "yyyy-MM-dd'T'HH:mm:ssZ"
    }
    
    func toString(withFormat format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = format
        formatter.locale = .current
        return formatter.string(from: self)
    }
}
