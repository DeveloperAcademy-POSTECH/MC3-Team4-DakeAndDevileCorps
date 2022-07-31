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
    private let itemTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "상품명*"
        label.textColor = .black
        label.font = .preferredFont(forTextStyle: .headline, compatibleWith: .init(legibilityWeight: .bold))
        return label
    }()
    private let reviewTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "리뷰*"
        label.textColor = .black
        label.font = .preferredFont(forTextStyle: .headline, compatibleWith: .init(legibilityWeight: .bold))
        return label
    }()
    private let itemTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "상품명을 입력해주세요"
        textfield.borderStyle = .none
        textfield.font = .preferredFont(forTextStyle: .subheadline)
        textfield.textColor = .label
        textfield.layer.borderColor = UIColor.separator.cgColor
        textfield.layer.borderWidth = 0.5
        textfield.layer.cornerRadius = 10
        textfield.setLeftPaddingWithLeftView(point: 16)
        textfield.clearButtonMode = .whileEditing
        return textfield
    }()
    private let categoryView = CategoryView(entryPoint: .write)
    private let reviewTextView = ReviewTextView()
    let reviewAddPhotoView = ReviewAddPhotoView()
    
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
        
        addSubview(itemTitleLabel)
        itemTitleLabel.constraint(top: categoryView.bottomAnchor,
                                  leading: categoryTitleLabel.leadingAnchor,
                                  padding: UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0))
        
        addSubview(itemTextField)
        itemTextField.constraint(top: itemTitleLabel.bottomAnchor,
                                 leading: self.leadingAnchor,
                                 trailing: self.trailingAnchor,
                                 padding: UIEdgeInsets(top: 10, left: 24, bottom: 0, right: 24))
        itemTextField.constraint(itemTextField.heightAnchor, constant: 48)
        
        addSubview(reviewTitleLabel)
        reviewTitleLabel.constraint(top: itemTextField.bottomAnchor,
                                    leading: categoryTitleLabel.leadingAnchor,
                                    padding: UIEdgeInsets(top: 22, left: 0, bottom: 0, right: 0))
        
        addSubview(reviewTextView)
        reviewTextView.constraint(top: reviewTitleLabel.bottomAnchor,
                                  leading: self.leadingAnchor,
                                  trailing: self.trailingAnchor,
                                  padding: UIEdgeInsets(top: 10, left: 24, bottom: 0, right: 24))
        addSubview(reviewAddPhotoView)
        reviewAddPhotoView.constraint(top: reviewTextView.bottomAnchor,
                                      leading: self.leadingAnchor,
                                      bottom: self.bottomAnchor,
                                      trailing: self.trailingAnchor,
                                      padding: UIEdgeInsets(top: 22, left: 24, bottom: 0, right: 12))
    }
}
