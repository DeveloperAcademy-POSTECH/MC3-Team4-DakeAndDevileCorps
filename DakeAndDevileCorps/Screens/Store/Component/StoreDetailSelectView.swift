//
//  StoreDetailSelectView.swift
//  DakeAndDevileCorps
//
//  Created by 최동권 on 2022/07/28.
//

import UIKit

protocol StoreDetailSelectViewDelegate: AnyObject {
    func showingReview()
    func showingProduct()
}

final class StoreDetailSelectView: UIView {
    
    // MARK: - properties
    
    private let productButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("취급상품 22", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        
        return button
    }()
    
    private let reviewButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("상품리뷰 4", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        
        return button
    }()
    
    private let writeReviewButton: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        let image = UIImageView(image: UIImage(systemName: "highlighter"))
        image.frame.size = CGSize(width: 20, height: 20)
        image.contentMode = .scaleAspectFit
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("리뷰쓰기", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        stackView.addArrangedSubview(image)
        stackView.addArrangedSubview(button)
       
        return stackView
    }()
    
    weak var delegate: StoreDetailSelectViewDelegate?
    // MARK: - init
    
    init() {
        super.init(frame: .zero)
        render()
        setupButtonAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - func
    
    private func render() {
       addSubview(productButton)
        NSLayoutConstraint.activate([
            productButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            productButton.topAnchor.constraint(equalTo: topAnchor, constant: 28)
        ])
        
        addSubview(reviewButton)
        NSLayoutConstraint.activate([
            reviewButton.leadingAnchor.constraint(equalTo: productButton.trailingAnchor, constant: 19),
            reviewButton.topAnchor.constraint(equalTo: productButton.topAnchor)
        ])
        
        addSubview(writeReviewButton)
        NSLayoutConstraint.activate([
            writeReviewButton.topAnchor.constraint(equalTo: productButton.topAnchor),
            writeReviewButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24)
        ])
    }
    
    private func setupButtonAction() {        
        let productButtonAction = UIAction { _ in
            self.delegate?.showingProduct()
        }
        productButton.addAction(productButtonAction, for: .touchUpInside)

        let reviewButtonACtion = UIAction { _ in
            self.delegate?.showingReview()
        }
        reviewButton.addAction(reviewButtonACtion, for: .touchUpInside)
    }
}
