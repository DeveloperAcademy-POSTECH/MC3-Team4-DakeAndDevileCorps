//
//  ShopInfo.swift
//  DakeAndDevileCorps
//
//  Created by Kim Sujin on 2022/07/27.
//

import MapKit

class ShopInfo: NSObject, MKAnnotation {
    enum Category {
        case zeroWasteShop
        case refillStation
        
        var image: UIImage {
            switch self {
            case .zeroWasteShop:
                return UIImage(systemName: "leaf.fill") ?? UIImage()
            case .refillStation:
                return UIImage(systemName: "drop.fill") ?? UIImage()
            }
        }
        
        var pinColor: UIColor {
            switch self {
            case .zeroWasteShop: return .zeroGreen50
            case .refillStation: return .zeroSky50
            }
        }
    }
    
    let title: String?
    let subtitle: String?
    
    let coordinate: CLLocationCoordinate2D
    
    let sellingProductsCategory: [String]
    let category: Category
    
    init(title: String? = nil, subtitle: String? = nil, coordinate: CLLocationCoordinate2D, sellingProductsCategory: [String], category: Category) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        self.sellingProductsCategory = sellingProductsCategory
        self.category = category
        
    }
}
