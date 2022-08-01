//
//  CustomModalView.swift
//  DakeAndDevileCorps
//
//  Created by Kim Sujin on 2022/08/01.
//

import UIKit

class CustomModalView: UIView {
//    enum ModalMode {
//        case tip
//        case full
//    }
//
//    var mode: ModalMode = .tip
//

    enum ModalMode: Equatable {
        case tip(screenViewFrame: CGRect)
        case full(screenViewFrame: CGRect)

        var frame: CGRect {
            switch self {
            case .tip(let screenViewFrame):
                return CGRect(x: 0,
                              y: screenViewFrame.height-150,
                              width: screenViewFrame.width,
                              height: 150)
            case .full(let screenViewFrame):
                return CGRect(x: 0,
                              y: 50,
                              width: screenViewFrame.width,
                              height: screenViewFrame.height-50)
            }
        }
    }

    var mode: ModalMode

    init(mode: ModalMode?) {
        if let mode = mode {
            self.mode = mode
        } else {
            self.mode = ModalMode.tip(screenViewFrame: .zero)
        }
        super.init(frame: mode?.frame ?? .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
