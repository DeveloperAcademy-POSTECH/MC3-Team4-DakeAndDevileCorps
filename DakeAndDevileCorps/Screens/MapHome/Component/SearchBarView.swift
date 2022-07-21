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
    
    weak var delegate: SearchBarDelegate?
    var leftItemMode: LeftItemMode = .imageMode {
        didSet {
            switch leftItemMode {
            case .imageMode:
                symbolImageView.isHidden = false
                leftButton.isHidden = true
            case .buttonMode:
                symbolImageView.isHidden = true
                leftButton.isHidden = false
            }
        }
    }
    var image: UIImage? = UIImage(systemName: "magnifyingglass") {
        didSet {
            symbolImageView.image = image
            leftButton.setImage(image, for: .normal)
        }
    }
    
    private lazy var symbolImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = image
        $0.contentMode = .scaleAspectFit
        if leftItemMode == .imageMode {
            $0.isHidden = false
        } else { $0.isHidden = true }
        $0.tintColor = .black
        return $0
    }(UIImageView())
    
    private lazy var leftButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setBackgroundImage(image, for: .normal)
        $0.sizeToFit()
        if leftItemMode == .buttonMode {
            $0.isHidden = false
        } else { $0.isHidden = true }
        $0.tintColor = .black
        return $0
    }(UIButton())
    
    private lazy var textField: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = "가게 이름, 상품 검색"
        return $0
    }(UITextField())

    init() {
        super.init(frame: .zero)
        textField.delegate = self
        setLeftButton()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }

    // MARK: - layout
    func configureLayout() {
        layer.cornerRadius = 10
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor

        heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        addSubview(textField)
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
        
        // TODO: symbolImageView, leftButton의 오토레이아웃 다시 맞추기
        addSubview(symbolImageView)
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: topAnchor, constant: 7),
            symbolImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -7),
            
            symbolImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            symbolImageView.trailingAnchor.constraint(equalTo: textField.leadingAnchor, constant: -8),
            
            symbolImageView.widthAnchor.constraint(equalToConstant: 16)
            
        ])
        
        addSubview(leftButton)
        NSLayoutConstraint.activate([
            leftButton.topAnchor.constraint(equalTo: topAnchor, constant: 7),
            leftButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -7),
            
            leftButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            symbolImageView.trailingAnchor.constraint(equalTo: textField.leadingAnchor, constant: -11)
        ])

    }
    
    // MARK: - leftButton setting
    private func setLeftButton() {
        leftButton.addTarget(self, action: #selector(touchUpInsideLeftButton), for: .touchUpInside)
    }
    
    @objc
    func touchUpInsideLeftButton() {
        delegate?.touchUpInsideLeftButton?()
    }
    
    enum LeftItemMode {
        case imageMode
        case buttonMode
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
