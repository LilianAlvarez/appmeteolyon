//
//  Date+.swift
//  Weather
//
//  Created by admin on 01/01/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation

extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
    }
    
    func timeStampToDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a "
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        return formatter.string(from: self)
    }

}
