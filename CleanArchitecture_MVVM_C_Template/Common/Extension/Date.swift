//
//  Date.swift
//  CleanArchitecture_MVVM_C_Template
//
//  Created by 조민호 on 2021/12/08.
//

import Foundation

extension String{
  func date(_ format: Date.Format)->Date?{
    Date.dfUTC(format).date(from: self)
  }
}

extension Calendar {
  static func local() -> Calendar {
    var calendar = Calendar.init(identifier: .iso8601)
    calendar.locale = .current
    calendar.timeZone = TimeZone.init(abbreviation: "UTC")!
    return calendar
  }
}

// Get
extension Date {

  func get(_ format: Date.Format) -> Int {
    Int(dfUTC(format).string(from: self)) ?? 0
  }

  func set(hour: Int, minute: Int, second: Int) -> Date{
    return dfUTC(.yyyyMMddHHmmSS).date(date: Calendar.local().date(bySettingHour: hour, minute: minute, second: second, of: self)!)
  }

  func getIn(_ minUnit: Int) -> Date{
    let minNow = get(.mm)
    let value = minNow - ((Int(minNow/minUnit)) * minUnit)
    let df = dfUTC(.yyyyMMddHHmmSS)

    var components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Calendar.current.date(byAdding: .minute, value: -value, to: self)!)
    components.second = 0

    return df.date(date: Calendar.current.date(from: components)!)
  }

  func string(_ format: Format)->String{
    dfUTC(format).string(from: self)
  }
}

// Compare
extension Date{
  public static func isAfter(from: Date, to: Date, format: Format) -> Bool{
    let df = Date.dfUTC(format)

    return (df.date(date: from) < df.date(date: to)) // to1 is after from1
  }
  
  public static func isAfterSinceNow(to: Date, format: Format) -> Bool{
    let now = Date.local()
    let df = Date.dfUTC(format)

    return (df.date(date: to) < df.date(date: now)) // to1 is after now1
  }

  public static func isBeforeSinceNow(to: Date, format: Format) -> Bool{
    let now = Date.local()
    let df = Date.dfUTC(format)

    return (df.date(date: now) < df.date(date: to)) // now1 is after to1
  }

}

// Parse
extension Date{
  public static func parse(timeStr: String, format: Format) -> Date?{
    Date.dfUTC(format).date(from: timeStr)
  }
  public static func parseNoUTC(timeStr: String, format: Format) -> Date?{
    Date.dfNoUTC(format).date(from: timeStr)
  }
  public static func parse(_ unixTimeStamp: CLong, _ format: Format) -> String{
    Date.dfUTC(format).string(from: Date.init(timeIntervalSince1970: TimeInterval.init(unixTimeStamp / 1000)))
  }
  public static func parseNoUTC(_ unixTimeStamp: CLong, _ format: Format) -> String{
    Date.dfNoUTC(format).string(from: Date.init(timeIntervalSince1970: TimeInterval.init(unixTimeStamp / 1000)))
  }
}

extension Date{

  public enum Format: String{
    case hh = "HH"
    case mm = "mm"
    case hh_MM = "HH : mm"
    case yyyyMMdd = "yyyy-MM-dd"
    case yyyyMMddHHmmSS = "yyyyMMdd HH:mm:ss"
    case iso8601 = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    case d = "d"
    case HH_mm = "HH:mm"
    case none = ""
  }

  static func local() -> Date {
    let nowUTC = Date()
    let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: nowUTC))

    return Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: nowUTC) ?? Date()
  }

  public static func dfUTC(_ format: Format)->DateFormatter{
    let df = DateFormatter.init()
    df.locale = Locale.current
    df.timeZone = TimeZone(abbreviation: "UTC")
    df.dateFormat = format.rawValue
    return df
  }

  public static func dfNoUTC(_ format: Format)->DateFormatter{
    let df = DateFormatter.init()
    df.dateFormat = format.rawValue
    return df
  }

  public func dfUTC(_ format: Format)->DateFormatter{
    let df = DateFormatter.init()
    df.locale = Locale.current
    df.timeZone = TimeZone(abbreviation: "UTC")
    df.dateFormat = format.rawValue
    return df
  }
  
  fileprivate static func string(date: Date, format: Format) -> String {
    Date.dfNoUTC(format).string(from: date)
  }
  
  fileprivate static func date(formatted: String, format: Format) -> Date? {
    Date.dfNoUTC(format).date(from: formatted)
  }
    
    func toString( dateFormat format: String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: self)
    }
    
    func toStringKST( dateFormat format: String ) -> String {
        return self.toString(dateFormat: format)
    }
    
    public static func dateConvertAmPm(string: String) -> String {
        let dateStr = string // Date 형태의 String
                
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                
        let convertDate = dateFormatter.date(from: dateStr)
                
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "a hh:mm"
        myDateFormatter.locale = Locale(identifier:"ko_KR") // PM, AM을 언어에 맞게 setting (ex: PM -> 오후)
        let convertStr = myDateFormatter.string(from: convertDate!)
        
        return convertStr
    }
    
}

extension DateFormatter{
  func date(date: Date)->Date{
    self.date(from: string(from: date))!
  }
}

extension Calendar {
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = startOfDay(for: from) // <1>
        let toDate = startOfDay(for: to) // <2>
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate) // <3>
        
        return numberOfDays.day!
    }
}
