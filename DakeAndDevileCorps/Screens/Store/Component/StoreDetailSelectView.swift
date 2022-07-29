//
//  StoreDetailSelectView.swift
//  DakeAndDevileCorps
//
//  Created by 최동권 on 2022/07/28.
//

import UIKit

protocol StoreDetailSelectViewDelegate: AnyObject {
    func showingReview(_ storeDetailSelectView: StoreDetailSelectView)
    func showingProduct(_ storeDetailSelectView: StoreDetailSelectView)
    func setUpNumberOfButtons(_ storeDetailSelectView: StoreDetailSelectView)
}

final class StoreDetailSelectView: UIView {
    
    // MARK: - properties
    
    weak var delegate: StoreDetailSelectViewDelegate?
    var isShowingReview: Bool = false
    var numberOfProducts: Int = 0 {
        didSet {
            productButton.setTitle("취급상품 \(numberOfProducts)", for: .normal)
        }
    }
    var numberOfReviews: Int = 0 {
        didSet {
            reviewButton.setTitle("상품리뷰 \(numberOfReviews)", for: .normal)
        }
    }
    
    let productButtonBottomBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        
        return view
    }()
    
    let reviewButtonBottomBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.isHidden = true
        
        return view
    }()
    
    private let productButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor( UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        
        return button
    }()
    
    private let reviewButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("상품리뷰 4", for: .normal)
        button.setTitleColor(UIColor.tertiaryLabel, for: .normal)
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
    
    // MARK: - init
    
    init() {
        super.init(frame: .zero)
        render()
        setupButtonAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        delegate?.setUpNumberOfButtons(self)
        super.draw(rect)
    }
    
    // MARK: - func
    
    private func render() {
        addSubview(productButton)
        productButton.setTitle("취급상품 \(numberOfProducts)", for: .normal)
        NSLayoutConstraint.activate([
            productButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            productButton.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        ])
        
        productButton.addSubview(productButtonBottomBar)
        NSLayoutConstraint.activate([
            productButtonBottomBar.heightAnchor.constraint(equalToConstant: 2),
            productButtonBottomBar.topAnchor.constraint(equalTo: productButton.bottomAnchor, constant: 2),
            productButtonBottomBar.widthAnchor.constraint(equalTo: productButton.widthAnchor)
        ])
        
        addSubview(reviewButton)
        reviewButton.setTitle("상품리뷰 \(numberOfReviews)", for: .normal)
        NSLayoutConstraint.activate([
            reviewButton.leadingAnchor.constraint(equalTo: productButton.trailingAnchor, constant: 19),
            reviewButton.topAnchor.constraint(equalTo: productButton.topAnchor)
        ])
        
        reviewButton.addSubview(reviewButtonBottomBar)
        NSLayoutConstraint.activate([
            reviewButtonBottomBar.heightAnchor.constraint(equalToConstant: 2),
            reviewButtonBottomBar.topAnchor.constraint(equalTo: reviewButton.bottomAnchor, constant: 2),
            reviewButtonBottomBar.widthAnchor.constraint(equalTo: reviewButton.widthAnchor)
        ])
        
        addSubview(writeReviewButton)
        NSLayoutConstraint.activate([
            writeReviewButton.topAnchor.constraint(equalTo: productButton.topAnchor),
            writeReviewButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24)
        ])
        
    }
    
    private func setupButtonAction() {
        let productButtonAction = UIAction { _ in
            self.delegate?.showingProduct(self)
        }
        productButton.addAction(productButtonAction, for: .touchUpInside)
        
        let reviewButtonACtion = UIAction { _ in
            self.delegate?.showingReview(self)
        }
        reviewButton.addAction(reviewButtonACtion, for: .touchUpInside)
    }
    
    func applyShowingState() {
        productButton.setTitleColor(isShowingReview ? UIColor.tertiaryLabel : UIColor.black, for: .normal)
        reviewButton.setTitleColor(isShowingReview ? UIColor.black : UIColor.tertiaryLabel, for: .normal)
    }
}
