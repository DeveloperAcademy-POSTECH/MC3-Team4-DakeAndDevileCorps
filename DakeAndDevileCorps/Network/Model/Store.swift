//
//  Store.swift
//  DakeAndDevileCorps
//
//  Created by SHIN YOON AH on 2022/08/01.
//

import UIKit

// MARK: - StoreModel
struct StoreModel: Codable {
    let data: [Store]
}

struct Store: Codable {
    let name: String
    let latitude, longitude: Double
    let address, telephone: String
    let officeHour: [String]
    let items: [Item]
    let comments: [Comment]
    
    enum CodingKeys: String, CodingKey {
        case name
        case officeHour = "office_hour"
        case items
        case latitude
        case longitude
        case address, telephone
        case comments
    }
}

extension Store {
    enum OfficeHourType {
        case open
        case close
        case holiday
        case none
        
        var title: String {
            switch self {
            case .open:
                return "영업 중"
            case .close:
                return "영업 종료"
            case .holiday:
                return "정기 휴무"
            case .none:
                return "문제 발생"
            }
        }
        
        var titleColor: UIColor {
            switch self {
            case .open:
                return .green
            case .close:
                return .red
            case .holiday:
                return .black
            case .none:
                return .gray
            }
        }
    }
    
    func getOfficeHourState() -> OfficeHourType {
        let currentTime = calculateTimeToInt(Date.getCurrentDate(with: "HH:mm"))
        guard let isIncludedInOfficeHour = getOfficeRange()?.contains(currentTime) else {
            if let officeHour = getTodayOfficeHour(), officeHour == "정기휴무" {
                return .holiday
            }
            return .none
        }
        
        return isIncludedInOfficeHour ? .open : .close
    }
    
    func getTodayOfficeHour() -> String? {
        let currentDate = Date.getCurrentDate(with: "E")
        
        switch currentDate {
        case "월":
            return officeHour[0]
        case "화":
            return officeHour[1]
        case "수":
            return officeHour[2]
        case "목":
            return officeHour[3]
        case "금":
            return officeHour[4]
        case "토":
            return officeHour[5]
        case "일":
            return officeHour[6]
        default:
            return nil
        }
    }
    
    func getOfficeRange() -> ClosedRange<Int>? {
        guard getTodayOfficeHour() != "정기휴무" else { return nil }
        let officeHours = getTodayOfficeHour()?.components(separatedBy: " - ")
        guard let startOfficeTime = officeHours?[0],
              let endOfficeTime = officeHours?[1] else { return nil }
        let officeRange: ClosedRange = calculateTimeToInt(startOfficeTime)...calculateTimeToInt(endOfficeTime)
        
        return officeRange
    }
    
    func getStoreCategories() -> String {
        var categories: [String] = []
        var categoryString: String = ""
        
        items.forEach { item in
            if !categories.contains(item.category) {
                categories.append(item.category)
            }
        }
        
        for (index, item) in categories.enumerated() {
            let itemString = index == (categories.count - 1) ? item : "\(item), "
            categoryString += itemString
            
            if index == 3 && categories.count > 4 {
                categoryString += "..."
                break
            }
        }
        
        return categoryString
    }
    
    private func calculateTimeToInt(_ time: String) -> Int {
        let times = time.components(separatedBy: ":")
        guard let hour = Int(times[0]),
              let minute = Int(times[1]) else { return 0 }
        
        return hour * 60 + minute
    }
}
