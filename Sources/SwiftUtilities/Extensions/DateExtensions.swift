//
//  Date.swift
//  SwiftUtilities
//
//  Created by Moi Gutierrez on 7/27/20.
//

import Foundation

public extension Date {

    func millisecondsSince1970(endianess: Endian) -> Int64 {
        switch endianess {
        case .big:
            return Int64(bigEndian: Int64((self.timeIntervalSince1970 * 1000.0).rounded()))
        case .little:
            return Int64(littleEndian: Int64((self.timeIntervalSince1970 * 1000.0).rounded()))
        }
    }

    func millisecondsSince1970(endianess: Endian) -> UInt64 {
        switch endianess {
        case .big:
            return UInt64(bigEndian: UInt64((self.timeIntervalSince1970 * 1000.0).rounded()))
        case .little:
            return UInt64(littleEndian: UInt64((self.timeIntervalSince1970 * 1000.0).rounded()))
        }
    }

    init(milliseconds: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000.0)
    }

    init(milliseconds: UInt64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000.0)
    }
}

public extension Date {
    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}

public extension Date {
 
    var relativeDateString: String {
        
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        formatter.dateTimeStyle = .named
        
        return formatter.localizedString(for: self, relativeTo: Date.now)
    }
    
}

public extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
}
