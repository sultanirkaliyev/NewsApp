//
//  StringExtension.swift
//  NewsApp
//
//  Created by Sultan on 11/13/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation

extension String {
    
    func convertStringToDate() -> Date? {
        
        let dateFormats = ["yyyy-MM-dd'T'HH:mm:ss",
                           "yyyy-MM-dd'T'HH:mm:ssZ",
                           "yyyy-MM-dd'T'HH:mm:ss.SSSZ",
                           "yyyy-MM-dd hh:mm:ss",
                           "yyyy-MM-dd",
                           "MM-dd-yyyy"]
        
        let localeID = Locale.preferredLanguages.first
        let dateFormatter = DateFormatter()
        
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.locale = Locale(identifier: localeID!)
        
        for dateFormatValue in dateFormats {
            
            dateFormatter.dateFormat = dateFormatValue
            
            if let dateFromString = dateFormatter.date(from: self) {
                let newStringFromDate = dateFormatter.string(from: dateFromString)
                let convertedDate = dateFormatter.date(from: newStringFromDate)
                return convertedDate!
            }
        }
        return nil
    }
}
