//
//  StoreDetailSelectView.swift
//  DakeAndDevileCorps
//
//  Created by 최동권 on 2022/07/28.
//

import UIKit

protocol StoreDetailSelectViewDelegate: AnyObject {
    func didSelectedButton(_ storeDetailSelectView: StoreDetailSelectView, isReviewButton: Bool, itemInformationType: ItemInformationType)
    func updateListCountOfButton(_ storeDetailSelectView: StoreDetailSelectView)
    func didTappedWriteReviewButton()
}

enum ItemInformationType {
    case productList
    case reviewList
    
    var isHiddenProductButtonBottomBar: Bool {
        switch self {
        case .productList:
            return false
        case .reviewList:
            return true
        }
    }
    
    var isHiddenReviewButtonBottomBar: Bool {
        switch self {
        case .productList:
            return true
        case .reviewList:
            return false
        }
    }
}

final class StoreDetailSelectView: UIView {
    
    // MARK: - properties
    
    weak var delegate: StoreDetailSelectViewDelegate?
//    var isShowingReview: Bool = false
    var iteminformationType: ItemInformationType = .productList
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
    
    private let productButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        
        return button
    }()
    
    private let reviewButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.tertiaryLabel, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        
        return button
    }()
    
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
    
    private let writeReviewButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "highlighter"), for: .normal)
        button.tintColor = UIColor.zeroMint50
        button.setTitle("리뷰쓰기", for: .normal)
        button.setTitleColor(UIColor.zeroMint50, for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .subheadline, compatibleWith: .init(legibilityWeight: .bold))
        
        return button
    }()
    
    // MARK: - init
    
    init() {
        super.init(frame: .zero)
        render()
        setupButtonTitle()
        setupButtonAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        delegate?.updateListCountOfButton(self)
        super.draw(rect)
    }
    
    // MARK: - func
    
    private func render() {
        addSubview(productButton)
        NSLayoutConstraint.activate([
            productButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            productButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        productButton.addSubview(productButtonBottomBar)
        NSLayoutConstraint.activate([
            productButtonBottomBar.heightAnchor.constraint(equalToConstant: 2),
            productButtonBottomBar.topAnchor.constraint(equalTo: productButton.bottomAnchor, constant: 2),
            productButtonBottomBar.widthAnchor.constraint(equalTo: productButton.widthAnchor)
        ])
        
        addSubview(reviewButton)
        NSLayoutConstraint.activate([
            reviewButton.leadingAnchor.constraint(equalTo: productButton.trailingAnchor, constant: 19),
            reviewButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        reviewButton.addSubview(reviewButtonBottomBar)
        NSLayoutConstraint.activate([
            reviewButtonBottomBar.heightAnchor.constraint(equalToConstant: 2),
            reviewButtonBottomBar.topAnchor.constraint(equalTo: reviewButton.bottomAnchor, constant: 2),
            reviewButtonBottomBar.widthAnchor.constraint(equalTo: reviewButton.widthAnchor)
        ])
        
        addSubview(writeReviewButton)
        NSLayoutConstraint.activate([
            writeReviewButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            writeReviewButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24)
        ])
    }
    
    private func setupButtonTitle() {
        productButton.setTitle("취급상품 \(numberOfProducts)", for: .normal)
        reviewButton.setTitle("상품리뷰 \(numberOfReviews)", for: .normal)
    }
    
    private func setupButtonAction() {
        let productButtonAction = UIAction { _ in
            self.iteminformationType = .productList
            self.delegate?.didSelectedButton(self,
                                             isReviewButton: false,
                                             itemInformationType: .productList)
        }
        productButton.addAction(productButtonAction, for: .touchUpInside)
        
        let reviewButtonAction = UIAction { _ in
            self.iteminformationType = .reviewList
            self.delegate?.didSelectedButton(self,
                                             isReviewButton: true,
                                             itemInformationType: .reviewList)
        }
        reviewButton.addAction(reviewButtonAction, for: .touchUpInside)
        
        let writeReviewButtonAction = UIAction { _ in
            self.delegate?.didTappedWriteReviewButton()
        }
        writeReviewButton.addAction(writeReviewButtonAction, for: .touchUpInside)
    }
    
    func applyShowingState() {
        switch iteminformationType {
        case .productList:
            productButton.setTitleColor(.black, for: .normal)
            reviewButton.setTitleColor(.tertiaryLabel, for: .normal)
        case .reviewList:
            productButton.setTitleColor(.tertiaryLabel, for: .normal)
            reviewButton.setTitleColor(.black, for: .normal)
        }
//        productButton.setTitleColor(isShowingReview ? UIColor.tertiaryLabel : UIColor.black, for: .normal)
//        reviewButton.setTitleColor(isShowingReview ? UIColor.black : UIColor.tertiaryLabel, for: .normal)
    }

    @objc func callPresentWrtieReviewView(_ sender: UITapGestureRecognizer) {
        delegate?.didTappedWriteReviewButton()
    }
}
