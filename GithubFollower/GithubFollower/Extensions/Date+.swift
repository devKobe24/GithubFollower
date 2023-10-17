//
//  Date+.swift
//  GithubFollower
//
//  Created by Minseong Kang on 10/17/23.
//

import Foundation

extension Date {
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
