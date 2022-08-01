//
//  UIColor+Extension.swift
//  DakeAndDevileCorps
//
//  Created by Seungyun Kim on 2022/07/18.
//

import UIKit

extension UIColor {

    static var zeroGreen50: UIColor {
        return UIColor(hex: "#47DC8C")
    }
    
    static var zeroGreen60: UIColor {
        return UIColor(hex: "#2FCE78")
    }
    
    static var zeroMint20: UIColor {
        return UIColor(hex: "#ABF1E5")
    }
    
    static var zeroMint50: UIColor {
        return UIColor(hex: "#00C9BD")
    }
    
    static var zeroSky50: UIColor {
        return UIColor(hex: "#4CCFF9")
    }
    
    static var zeroRed: UIColor {
        return UIColor(hex: "#FF5F5F")
    }
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        assert(hexFormatted.count == 6, "Invalid hex code used.")
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: alpha)
    }
}
