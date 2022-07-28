//
//  ShopInfo.swift
//  DakeAndDevileCorps
//
//  Created by Kim Sujin on 2022/07/27.
//

import MapKit


class ShopInfo: NSObject, MKAnnotation {
    let title: String?
    let subtitle: String?
    
    let coordinate: CLLocationCoordinate2D
    
    let sellingProductsCategory: [String]
    
    init(title: String? = nil, subtitle: String? = nil, coordinate: CLLocationCoordinate2D, sellingProductsCategory: [String]) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        self.sellingProductsCategory = sellingProductsCategory
        
        super.init()
    }
}
