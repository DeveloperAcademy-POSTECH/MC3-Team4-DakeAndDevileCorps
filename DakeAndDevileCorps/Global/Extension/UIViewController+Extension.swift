//
//  UIViewController+Extension.swift
//  DakeAndDevileCorps
//
//  Created by SHIN YOON AH on 2022/07/29.
//

import UIKit

extension UIViewController {
    func hidekeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
