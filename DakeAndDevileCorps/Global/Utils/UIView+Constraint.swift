//
//  UIView+Constraint.swift
//  DakeAndDevileCorps
//
//  Created by SHIN YOON AH on 2022/07/26.
//

import UIKit

enum ConstraintType {
    case top, leading, trailing, bottom, centerX, centerY, width, height
}

extension UIView {

    @discardableResult
    func constraint(
        top: (NSLayoutYAxisAnchor, CGFloat)? = nil,
        leading: (NSLayoutXAxisAnchor, CGFloat)? = nil,
        bottom: (NSLayoutYAxisAnchor, CGFloat)? = nil,
        trailing: (NSLayoutXAxisAnchor, CGFloat)? = nil,
        centerX: (NSLayoutXAxisAnchor, CGFloat)? = nil,
        centerY: (NSLayoutYAxisAnchor, CGFloat)? = nil,
        width: (NSLayoutDimension?, CGFloat?)? = nil,
        height: (NSLayoutDimension?, CGFloat?)? = nil
    ) -> [ConstraintType: NSLayoutConstraint] {
        self.translatesAutoresizingMaskIntoConstraints = false
        var constraints: [ConstraintType: NSLayoutConstraint] = [:]

        if let top = top {
            let constant = top.1
            let targetAnchor = top.0
            constraints[.top] = self.topAnchor.constraint(equalTo: targetAnchor, constant: constant)
        }
        
        if let leading = leading {
            let constant = leading.1
            let targetAnchor = leading.0
            constraints[.leading] = self.leadingAnchor.constraint(equalTo: targetAnchor, constant: constant)
        }
        
        if let bottom = bottom {
            let constant = bottom.1
            let targetAnchor = bottom.0
            constraints[.bottom] = self.bottomAnchor.constraint(equalTo: targetAnchor, constant: constant)
        }
        
        if let trailing = trailing {
            let constant = trailing.1
            let targetAnchor = trailing.0
            constraints[.trailing] = self.trailingAnchor.constraint(equalTo: targetAnchor, constant: constant)
        }
        
        if let centerX = centerX {
            let constant = centerX.1
            let targetAnchor = centerX.0
            constraints[.centerX] = self.centerXAnchor.constraint(equalTo: targetAnchor, constant: constant)
        }
        
        if let centerY = centerY {
            let constant = centerY.1
            let targetAnchor = centerY.0
            constraints[.centerY] = self.centerYAnchor.constraint(equalTo: targetAnchor, constant: constant)
        }
        
        if let width = width {
            if let target = width.0 {
                let constant = width.1 ?? 0
                constraints[.width] = self.widthAnchor.constraint(equalTo: target, constant: constant)
            } else if let constant = width.1 {
                constraints[.width] = self.widthAnchor.constraint(equalToConstant: constant)
            }
        }
        
        if let height = height {
            if let target = height.0 {
                let constant = height.1 ?? 0
                constraints[.height] = self.heightAnchor.constraint(equalTo: target, constant: constant)
            } else if let constant = height.1 {
                constraints[.height] = self.heightAnchor.constraint(equalToConstant: constant)
            }
        }
        
        let constraintsArray: [NSLayoutConstraint] = Array(constraints.values)
        NSLayoutConstraint.activate(constraintsArray)
        
        return constraints
    }
    
    func constraint(_ anchor: NSLayoutDimension, constant: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        anchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func constraint(to layoutGuide: UILayoutGuide, insets: UIEdgeInsets = .zero, direction: UIRectEdge = .all) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let top = NSLayoutConstraint(item: self,
                                     attribute: .top,
                                     relatedBy: .equal,
                                     toItem: layoutGuide,
                                     attribute: .top,
                                     multiplier: 1,
                                     constant: insets.top)
        
        let bottom = NSLayoutConstraint(item: self,
                                        attribute: .bottom,
                                        relatedBy: .equal,
                                        toItem: layoutGuide,
                                        attribute: .bottom,
                                        multiplier: 1,
                                        constant: insets.bottom)
        
        let leading = NSLayoutConstraint(item: self,
                                         attribute: .leading,
                                         relatedBy: .equal,
                                         toItem: layoutGuide,
                                         attribute: .leading,
                                         multiplier: 1,
                                         constant: insets.left)
        
        let trailing = NSLayoutConstraint(item: self,
                                          attribute: .trailing,
                                          relatedBy: .equal,
                                          toItem: layoutGuide,
                                          attribute: .trailing,
                                          multiplier: 1,
                                          constant: insets.right)
        
        if direction.contains(.top) { top.isActive = true }
        if direction.contains(.bottom) { bottom.isActive = true }
        if direction.contains(.left) { leading.isActive = true }
        if direction.contains(.right) { trailing.isActive = true }
    }
    
    func constraint(to view: UIView, insets: UIEdgeInsets = .zero, direction: UIRectEdge = .all) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let top = NSLayoutConstraint(item: self,
                                     attribute: .top,
                                     relatedBy: .equal,
                                     toItem: view,
                                     attribute: .top,
                                     multiplier: 1,
                                     constant: insets.top)
        
        let bottom = NSLayoutConstraint(item: self,
                                        attribute: .bottom,
                                        relatedBy: .equal,
                                        toItem: view,
                                        attribute: .bottom,
                                        multiplier: 1,
                                        constant: insets.bottom)
        
        let leading = NSLayoutConstraint(item: self,
                                         attribute: .leading,
                                         relatedBy: .equal,
                                         toItem: view,
                                         attribute: .leading,
                                         multiplier: 1,
                                         constant: insets.left)
        
        let trailing = NSLayoutConstraint(item: self,
                                          attribute: .trailing,
                                          relatedBy: .equal,
                                          toItem: view,
                                          attribute: .trailing,
                                          multiplier: 1,
                                          constant: insets.right)
        
        if direction.contains(.top) { top.isActive = true }
        if direction.contains(.bottom) { bottom.isActive = true }
        if direction.contains(.left) { leading.isActive = true }
        if direction.contains(.right) { trailing.isActive = true }
    }
    
    @discardableResult
    func constraint(top: NSLayoutYAxisAnchor? = nil,
                    leading: NSLayoutXAxisAnchor? = nil,
                    bottom: NSLayoutYAxisAnchor? = nil,
                    trailing: NSLayoutXAxisAnchor? = nil,
                    centerX: NSLayoutXAxisAnchor? = nil,
                    centerY: NSLayoutYAxisAnchor? = nil,
                    padding: UIEdgeInsets = .zero) -> [ConstraintType: NSLayoutConstraint] {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints: [ConstraintType: NSLayoutConstraint] = [:]
        
        if let top = top {
            constraints[.top] = topAnchor.constraint(equalTo: top, constant: padding.top)
        }
        
        if let leading = leading {
            constraints[.leading] = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        
        if let bottom = bottom {
            constraints[.bottom] = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }
        
        if let trailing = trailing {
            constraints[.trailing] = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }
        
        if let centerX = centerX {
            constraints[.centerX] = centerXAnchor.constraint(equalTo: centerX)
        }
        
        if let centerY = centerY {
            constraints[.centerY] = centerYAnchor.constraint(equalTo: centerY)
        }
        
        let constraintsArray: [NSLayoutConstraint] = Array(constraints.values)
        NSLayoutConstraint.activate(constraintsArray)
        return constraints
    }
}
