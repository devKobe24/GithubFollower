//
//  String+.swift
//  GithubFollower
//
//  Created by Minseong Kang on 10/17/23.
//

import Foundation
import OSLog

extension String {
    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current
        
        guard let convertResultDate = dateFormatter.date(from: self) else {
            Logger().error("⛔️Error: Convert to String Error")
            return nil
        }
        
        return convertResultDate
    }
    
    func convertDateToDisplayFormat() -> String {
        guard let date = self.convertToDate() else {
            Logger().error("⛔️Error: Convert to Date Error")
            return "N/A"
        }
        
        return date.convertToMonthYearFormat()
    }
}
