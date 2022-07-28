//
//  ReviewTextView.swift
//  DakeAndDevileCorps
//
//  Created by SHIN YOON AH on 2022/07/27.
//

import UIKit

final class ReviewTextView: UIView {
    
    // MARK: - properties
    
    private let borderView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.separator.cgColor
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = 10
        return view
    }()
    private let counterLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .preferredFont(forTextStyle: .caption2,
                                    compatibleWith: .init(legibilityWeight: .bold))
        label.text = "0/300"
        return label
    }()
    private let reviewTextView: UITextView = {
        let textView = UITextView()
        textView.font = .preferredFont(forTextStyle: .subheadline)
        return textView
    }()

    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - func
    
    private func render() {
        addSubview(borderView)
        borderView.constraint(to: self)
        borderView.constraint(borderView.heightAnchor, constant: 137)
        
        borderView.addSubview(counterLabel)
        counterLabel.constraint(bottom: self.bottomAnchor,
                                trailing: self.trailingAnchor,
                                padding: UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 16))
        
        borderView.addSubview(reviewTextView)
        reviewTextView.constraint(top: borderView.topAnchor,
                                  leading: borderView.leadingAnchor,
                                  bottom: counterLabel.bottomAnchor,
                                  trailing: borderView.trailingAnchor,
                                  padding: UIEdgeInsets(top: 16, left: 16, bottom: 12, right: 16))
    }
    
}
