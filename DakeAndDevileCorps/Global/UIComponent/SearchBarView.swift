//
//  SearchBarView.swift
//  DakeAndDevileCorps
//
//  Created by Kim Sujin on 2022/07/20.
//

import UIKit

@objc protocol SearchBarDelegate {
    @objc optional func didReturnKeyInput()
    @objc optional func didBeginEditing()
    @objc optional func touchUpInsideLeftButton()
}

class SearchBarView: UIView {
    
    enum EntryPoint {
        case Map
        case Search
        
        var symbolImageHidden: Bool {
            switch self {
            case .Map: return false
            case .Search: return true
            }
        }
        
        var backButtonHidden: Bool {
            switch self {
            case .Map: return true
            case .Search: return false
            }
        }
        
        var myPageButtonIsHidden: Bool {
            switch self {
            case .Map: return false
            case .Search: return true
            }
        }
    }

    var text: String {
        get { return textField.text ?? "" }
        set(value) { textField.text = value }
    }
    
    weak var delegate: SearchBarDelegate?
    var entryPoint: EntryPoint = .Map {
        didSet {
            setLeftItemIsHidden()
            setRightItem()
        }
    }

    private lazy var symbolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "magnifyingglass")
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = entryPoint.symbolImageHidden
        imageView.tintColor = .black
        return imageView
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.sizeToFit()
        button.isHidden = entryPoint.backButtonHidden
        button.tintColor = .black
        return button
    }()
    
    private lazy var myPageButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "person.crop.circle"), for: .normal)
        button.sizeToFit()
        button.isHidden = entryPoint.myPageButtonIsHidden
        button.tintColor = .systemGray4
        return button
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "가게 이름, 상품 검색"
        return textField
    }()
    
    private lazy var containerView: UIView = {
       let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()

    init() {
        super.init(frame: .zero)
        setTextField()
        setLeftButton()
        configure()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func draw(_ rect: CGRect) {
        configure()
        super.draw(rect)
    }

    // MARK: - configure
    private func configure() {
        containerView.layer.cornerRadius = 24
        containerView.layer.borderWidth = 0.5
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        
        containerView.backgroundColor = .white
    }
    
    // MARK: - layout
    private func configureLayout() {
        heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        addSubview(containerView)
        containerView.addSubview(symbolImageView)
        containerView.addSubview(backButton)
        containerView.addSubview(myPageButton)
        containerView.addSubview(textField)
        
        // MARK: containerView layout
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        // MARK: textField layout
        let textFieldLeadingToLeftImage: NSLayoutConstraint = {
            let constraint = textField.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 11)
            constraint.priority = .defaultLow
            return constraint
        }()
        let textFieldLeadingToLeftButton: NSLayoutConstraint = {
            let constraint = textField.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 11)
            constraint.priority = .defaultLow
            return constraint
        }()
        let textFieldTrailingToRightButton: NSLayoutConstraint = {
            let constraint = textField.trailingAnchor.constraint(equalTo: myPageButton.leadingAnchor, constant: -8)
            constraint.priority = .defaultLow
            return constraint
        }()
        let textFieldTrailingToContainer: NSLayoutConstraint = {
            let constraint = textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8)
            constraint.priority = .defaultLow
            return constraint
        }()
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: containerView.topAnchor),
            textField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            textFieldLeadingToLeftImage,
            textFieldLeadingToLeftButton,
            textFieldTrailingToRightButton,
            textFieldTrailingToContainer
        ])

        // MARK: symbolImageView layout
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 13),
            symbolImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -13),
            symbolImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            
            symbolImageView.widthAnchor.constraint(equalToConstant: 21)
        ])
        
        // MARK: leftButton layout
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 13),
            backButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -13),
            backButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            
            backButton.widthAnchor.constraint(equalToConstant: 13)
        ])
        
        // MARK: myPageButton
        NSLayoutConstraint.activate([
            myPageButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            myPageButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
            myPageButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            myPageButton.widthAnchor.constraint(equalToConstant: 24)
        ])
        
    }
    
    // MARK: - set components
    private func setLeftItemIsHidden() {
        backButton.isHidden = entryPoint.backButtonHidden
        symbolImageView.isHidden = entryPoint.symbolImageHidden
    }

    private func setRightItem() {
        myPageButton.isHidden = entryPoint.myPageButtonIsHidden
    }
    
    // MARK: - set TextField
    private func setTextField() {
        textField.delegate = self
    }
    
    // MARK: - leftButton setting
    private func setLeftButton() {
        backButton.addTarget(self, action: #selector(touchUpInsideLeftButton), for: .touchUpInside)
    }
    
    @objc
    private func touchUpInsideLeftButton() {
        delegate?.touchUpInsideLeftButton?()
    }

}

// MARK: - UITextFieldDelegate
extension SearchBarView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.didBeginEditing?()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.didReturnKeyInput?()
        return true
    }
}

// MARK: - use Canvas
 #if DEBUG
 import SwiftUI

 struct SearchBarViewRepresentable: UIViewRepresentable {
    typealias UIViewType = SearchBarView

    func makeUIView(context: Context) -> SearchBarView {
        return SearchBarView()
    }

    func updateUIView(_ uiView: SearchBarView, context: Context) {

    }
 }

 @available(iOS 13.0.0, *)
 struct SearchBarViewRepresentable_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarViewRepresentable()
            .frame(width: 375, height: 50)
            .previewLayout(.sizeThatFits)
    }
 }
 #endif
