//
//  UserDefaultHandler.swift
//  DakeAndDevileCorps
//
//  Created by SHIN YOON AH on 2022/08/01.
//

import Foundation

struct UserDefaultHandler {
    static func clearAllData() {
        UserData<Any>.clearAll()
    }
    
    static func setNickname(nickname: String) {
        UserData.setValue(nickname, forKey: .nickname)
    }
    
    static func setCurrentLatitude(currentLatitude: String) {
        UserData.setValue(currentLatitude, forKey: .currentLatitude)
    }
    
    static func setCurrentLongitude(currentLongitude: String) {
        UserData.setValue(currentLongitude, forKey: .currentLongitude)
    }
    
}

