//
//  AnnotationView.swift
//  DakeAndDevileCorps
//
//  Created by Kim Sujin on 2022/07/28.
//

import MapKit

class AnnotationView: MKMarkerAnnotationView {
    
    override func draw(_ rect: CGRect) {        
        guard let annotation = annotation as? StoreAnnotation else {
            super.draw(rect)
            return
        }
        
        glyphImage = annotation.category.image
        glyphTintColor = .white
        markerTintColor = annotation.category.pinColor
        
        super.draw(rect)
    }

}
