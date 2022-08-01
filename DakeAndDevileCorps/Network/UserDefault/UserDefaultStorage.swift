//
//  UserDefaultStorage.swift
//  DakeAndDevileCorps
//
//  Created by SHIN YOON AH on 2022/08/01.
//

import Foundation

enum DataKeys: String, CaseIterable {
    case nickname
    case currentLatitude
    case currentLongitude
}

struct UserDefaultStorage {
    static var nickname: String {
        return UserData<String>.getValue(forKey: .nickname) ?? ""
    }
    
    static var currentLatitude: String {
        return UserData<String>.getValue(forKey: .currentLatitude) ?? ""
    }
    
    static var currentLongitude: String {
        return UserData<String>.getValue(forKey: .currentLongitude) ?? ""
    }
}

struct UserData<T> {
    static func getValue(forKey key: DataKeys) -> T? {
        if let data = UserDefaults.standard.value(forKey: key.rawValue) as? T {
            return data
        } else {
            return nil
        }
    }
    
    static func setValue(_ value: T, forKey key: DataKeys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    static func clearAll() {
        DataKeys.allCases.forEach { key in
            UserDefaults.standard.removeObject(forKey: key.rawValue)
        }
    }
    
    static func clear(forKey key: DataKeys) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
}
