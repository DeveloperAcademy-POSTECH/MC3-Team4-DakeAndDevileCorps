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
    
    enum LeftItemMode {
        case imageMode
        case buttonMode
        
        var imageHidden: Bool {
            switch self {
            case .imageMode: return false
            case .buttonMode: return true
            }
        }
        
        var buttonHidden: Bool {
            switch self {
            case .imageMode: return true
            case .buttonMode: return false
            }
        }
    }
    
    weak var delegate: SearchBarDelegate?
    var leftItemMode: LeftItemMode = .imageMode {
        didSet {
            setComponentsIsHidden()
        }
    }
    var leftItemImage: UIImage = UIImage(systemName: "magnifyingglass") ?? UIImage() {
        didSet {
            symbolImageView.image = leftItemImage
            leftButton.setImage(leftItemImage, for: .normal)
        }
    }
    
    private lazy var symbolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = leftItemImage
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = leftItemMode.imageHidden
        imageView.tintColor = .black
        return imageView
    }()
    
    private lazy var leftButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(leftItemImage, for: .normal)
        button.sizeToFit()
        button.isHidden = leftItemMode.buttonHidden
        button.tintColor = .black
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
        super.draw(rect)
    }

    // MARK: - configure
    private func configure() {
        containerView.layer.cornerRadius = 10
        containerView.layer.borderWidth = 0.5
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        
        containerView.backgroundColor = .white
    }
    
    // MARK: - layout
    private func configureLayout() {
        heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        containerView.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
        
        containerView.addSubview(symbolImageView)
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: topAnchor, constant: 7),
            symbolImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -7),
            
            symbolImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            symbolImageView.trailingAnchor.constraint(equalTo: textField.leadingAnchor, constant: -8),
            
            symbolImageView.widthAnchor.constraint(equalToConstant: 16)
            
        ])
        
        containerView.addSubview(leftButton)
        NSLayoutConstraint.activate([
            leftButton.topAnchor.constraint(equalTo: topAnchor, constant: 7),
            leftButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -7),
            
            leftButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            symbolImageView.trailingAnchor.constraint(equalTo: textField.leadingAnchor, constant: -11)
        ])

    }
    
    // MARK: - set components
    private func setComponentsIsHidden() {
        leftButton.isHidden = leftItemMode.buttonHidden
        symbolImageView.isHidden = leftItemMode.imageHidden
    }
    
    // MARK: - set TextField
    private func setTextField() {
        textField.delegate = self
    }
    
    // MARK: - leftButton setting
    private func setLeftButton() {
        leftButton.addTarget(self, action: #selector(touchUpInsideLeftButton), for: .touchUpInside)
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
