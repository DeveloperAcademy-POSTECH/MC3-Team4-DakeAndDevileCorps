//
//  StoreAnnotation.swift
//  DakeAndDevileCorps
//
//  Created by SHIN YOON AH on 2022/08/01.
//

import MapKit

class StoreAnnotation: NSObject, MKAnnotation {
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
    
    let coordinate: CLLocationCoordinate2D
    let sellingProductsCategory: [String]
    let category: Category
    let store: Store
    
    init(title: String? = nil, subtitle: String? = nil, coordinate: CLLocationCoordinate2D, sellingProductsCategory: [String], category: Category, store: Store) {
        self.coordinate = coordinate
        self.sellingProductsCategory = sellingProductsCategory
        self.category = category
        self.store = store
    }
}
