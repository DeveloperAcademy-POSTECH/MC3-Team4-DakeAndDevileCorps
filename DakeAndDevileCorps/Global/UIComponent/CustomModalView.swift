//
//  CustomModalView.swift
//  DakeAndDevileCorps
//
//  Created by Kim Sujin on 2022/08/01.
//

import UIKit

class CustomModalView: UIView {
    enum ModalMode: Equatable {
        case tip
        case full

        func generateFrame(screenViewFrame: CGRect) -> CGRect {
            switch self {
            case .tip:
                return CGRect(
                    x: 0,
                    y: screenViewFrame.height - 150,
                    width: screenViewFrame.width,
                    height: 150
                )
            case .full:
                return CGRect(
                    x: 0,
                    y: 50,s
                    width: screenViewFrame.width,
                    height: screenViewFrame.height - 50
                )
            }
        }
        
    }

    var mode: ModalMode
    let superScreenViewFrame: CGRect

    init(mode: ModalMode?, superScreenViewFrame: CGRect?) {
        self.superScreenViewFrame = superScreenViewFrame ?? .zero
        self.mode = mode ?? ModalMode.tip
        
        super.init(frame: self.mode.generateFrame(screenViewFrame: self.superScreenViewFrame)
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
