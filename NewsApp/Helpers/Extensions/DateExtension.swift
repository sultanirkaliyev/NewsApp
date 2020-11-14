//
//  DateExtension.swift
//  NewsApp
//
//  Created by Sultan on 11/13/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation

extension Date {
    
    func getFormattedDate(format: String) -> String {
        let dateFormatter = DateFormatter()
        let localeID = Locale.preferredLanguages.first
        dateFormatter.locale = Locale(identifier: localeID!)
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func timeAgoDisplay() -> String {
        
        let calendar = Calendar.current
        let minuteAgo = calendar.date(byAdding: .minute, value: -1, to: Date())!
        let hourAgo = calendar.date(byAdding: .hour, value: -1, to: Date())!
        let dayAgo = calendar.date(byAdding: .day, value: -1, to: Date())!
        let weekAgo = calendar.date(byAdding: .day, value: -7, to: Date())!
        
        if minuteAgo < self {
            let diff = Calendar.current.dateComponents([.second], from: self, to: Date()).second ?? 0
            return "\(diff) sec ago"
        } else if hourAgo < self {
            let diff = Calendar.current.dateComponents([.minute], from: self, to: Date()).minute ?? 0
            return "\(diff) min ago"
        } else if dayAgo < self {
            let diff = Calendar.current.dateComponents([.hour], from: self, to: Date()).hour ?? 0
            if diff == 1{
                return "\(diff) hr ago"
            }else{
                return "\(diff) hrs ago"
            }
        } else if weekAgo < self {
            let diff = Calendar.current.dateComponents([.day], from: self, to: Date()).day ?? 0
            if diff == 1{
                return "\(diff) day ago"
            }else{
                return "\(diff) days ago"
            }
        }
        let diff = Calendar.current.dateComponents([.weekOfYear], from: self, to: Date()).weekOfYear ?? 0
        if diff == 1{
            return "\(diff) week ago"
        }else{
            return "\(diff) weeks ago"
        }
    }
}
