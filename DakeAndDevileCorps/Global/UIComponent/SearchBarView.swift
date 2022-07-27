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
        
        var image : UIImage {
            switch self {
            case .imageMode: return UIImage(systemName: "magnifyingglass") ?? UIImage()
            case .buttonMode: return UIImage(systemName: "chevron.backward") ?? UIImage()
            }
        }
    }
    
    enum RightItemMode {
        case myPageButton
        case none
        
        var myPageButtonHidden: Bool {
            switch self {
            case .myPageButton: return false
            case .none: return true
            }
        }
    }
    
    var text: String {
        get { return textField.text ?? "" }
        set(value) { textField.text = value }
    }
    
    weak var delegate: SearchBarDelegate?
    var leftItemMode: LeftItemMode = .imageMode {
        didSet {
            setLeftItemIsHidden()
        }
    }
    var rightItemMode: RightItemMode = .myPageButton {
        didSet {
            setRightItem()
        }
    }
    
    private lazy var symbolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = leftItemMode.image
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = leftItemMode.imageHidden
        imageView.tintColor = .black
        return imageView
    }()
    
    private lazy var leftButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(leftItemMode.image, for: .normal)
        button.sizeToFit()
        button.isHidden = leftItemMode.buttonHidden
        button.tintColor = .black
        return button
    }()
    
    private lazy var myPageButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "person.crop.circle"), for: .normal)
        button.sizeToFit()
        button.isHidden = rightItemMode.myPageButtonHidden
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
        containerView.addSubview(leftButton)
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
            let constraint = textField.leadingAnchor.constraint(equalTo: leftButton.trailingAnchor, constant: 11)
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
            leftButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 13),
            leftButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -13),
            leftButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            
            leftButton.widthAnchor.constraint(equalToConstant: 13)
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
        leftButton.isHidden = leftItemMode.buttonHidden
        symbolImageView.isHidden = leftItemMode.imageHidden
    }

    private func setRightItem() {
        myPageButton.isHidden = rightItemMode.myPageButtonHidden
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
