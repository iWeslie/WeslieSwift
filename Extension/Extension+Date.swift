/*:
 * Extension+String.swift
 * Created by Weslie
 * Copyright © 2019 Weslie. All rights reserved.
 */

import Foundation

struct QuoteDate {
    
    var month: String = "Jan"
    var day: String = "1st"
    var monthIntValue: Int = 1
    var dateString: String
    var dayNum: Int = 0
    
    init?(dateString: String?) {
        guard let dateString = dateString else {
            self.dateString = "2018/01/01"
            return
        }
        
        self.dateString = dateString
        let dateArr = dateString.split(separator: "/")
        let month = Int(dateArr[1])
        let day = Int(dateArr[2])
        guard let monthValue = month, 01...12 ~= monthValue,
              let dayValue = day, 01...31 ~= dayValue else { return }
        dayNum = dayValue
        switch monthValue {
        case 1: self.month = "Jan"
        case 2: self.month = "Feb"
        case 3: self.month = "Mar"
        case 4: self.month = "Apr"
        case 5: self.month = "May"
        case 6: self.month = "Jun"
        case 7: self.month = "Jul"
        case 8: self.month = "Aug"
        case 9: self.month = "Sept"
        case 10:self.month = "Oct"
        case 11:self.month = "Nov"
        case 12:self.month = "Dec"
        default: break
        }
        monthIntValue = monthValue
        switch dayValue {
        case 1: self.day = "1st"
        case 2: self.day = "2nd"
        case 3: self.day = "3rd"
        default: self.day = "\(dayValue)th"
        }
    }
}

extension QuoteDate: Comparable {
	static func < (lhs: QuoteDate, rhs: QuoteDate) -> Bool {
		return lhs.dateString < rhs.dateString
	}
	
	static func > (lhs: QuoteDate, rhs: QuoteDate) -> Bool {
		return lhs.dateString > rhs.dateString
	}
}

extension Date {
    /// convert date to quote date format
    func convertToQuoteDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let dateString = formatter.string(from: self)
        return dateString
    }
    
    /// get current date as String
    static func getCurrent() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd"
        let date = formatter.string(from: Date())
        return date
    }
    
    /// Timestamp and Date Converting
    static func convert(from string: String?) -> Date? {
        let timeZone = TimeZone(identifier: "UTC")
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.locale = Locale(identifier: "zh_CN")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let date = formatter.date(from: string ?? "")
        return date
    }
    
    /// get Created at date string
    static func getCreatedTime(from date: Date?) -> String {
        let currentDate = Date()
        guard date != nil else { return "" }
        let interval = Int(currentDate.timeIntervalSince(date!))
        switch interval {
        case ..<60:
            return NSLocalizedString("Just now", comment: "")
        case ..<(60 * 60):
			let min = interval / 60
			let intervalStr = min == 1 ? "minute ago" : "mins ago"
			return "\(min) " + NSLocalizedString(intervalStr, comment: "")
        case ..<(60 * 60 * 24):
			let hour = interval / (60 * 60)
			let intervalStr = hour == 1 ? "hour ago" : "hours ago"
			return "\(hour) " + NSLocalizedString(intervalStr, comment: "")
        case ..<(60 * 60 * 24 * 31):
			let day = interval / (60 * 60 * 24)
			let intervalStr = day == 1 ? "day ago" : "days ago"
			return "\(day) " + NSLocalizedString(intervalStr, comment: "")
        case ..<(60 * 60 * 24 * 31 * 12):
			let month = interval / (60 * 60 * 24 * 31)
			let intervalStr = month == 1 ? "month ago" : "months ago"
            return "\(month) " + NSLocalizedString(intervalStr, comment: "")
        default:
			let year = interval / (60 * 60 * 24 * 365)
			let intervalStr = year == 1 ? "month ago" : "months ago"
			return "\(year) " + NSLocalizedString(intervalStr, comment: "")
        }
    }
}
