//
//  UIColor+Extension.swift
//  DakeAndDevileCorps
//
//  Created by Seungyun Kim on 2022/07/18.
//

import UIKit

extension UIColor {

    static var zeroGreen50: UIColor {
        return UIColor(hex: "#6EDBA0")
    }
    
    static var zeroGreen60: UIColor {
        return UIColor(hex: "#53C989")
    }
    
    static var zeroMint20: UIColor {
        return UIColor(hex: "#ABF1E5")
    }
    
    static var zeroMint50: UIColor {
        return UIColor(hex: "#01D2B8")
    }
    
    static var zeroSky50: UIColor {
        return UIColor(hex: "#69D3F5")
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
