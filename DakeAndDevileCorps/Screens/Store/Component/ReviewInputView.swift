//
//  ReviewInputView.swift
//  DakeAndDevileCorps
//
//  Created by SHIN YOON AH on 2022/07/27.
//

import UIKit

final class ReviewInputView: UIView {

    // MARK: - properties
    
    private let categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "카테고리*"
        label.textColor = .black
        label.font = .preferredFont(forTextStyle: .headline, compatibleWith: .init(legibilityWeight: .bold))
        return label
    }()
    private let categoryView = CategoryView(entryPoint: .write)
    
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
        addSubview(categoryTitleLabel)
        categoryTitleLabel.constraint(top: self.topAnchor,
                                      leading: self.leadingAnchor,
                                      padding: UIEdgeInsets(top: 24, left: 24, bottom: 0, right: 0))
        
        addSubview(categoryView)
        categoryView.constraint(top: categoryTitleLabel.bottomAnchor,
                                leading: self.leadingAnchor,
                                trailing: self.trailingAnchor,
                                padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        categoryView.constraint(categoryView.heightAnchor, constant: 60)
    }
}
