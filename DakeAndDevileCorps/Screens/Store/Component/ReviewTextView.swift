//
//  ReviewTextView.swift
//  DakeAndDevileCorps
//
//  Created by SHIN YOON AH on 2022/07/27.
//

import UIKit

final class ReviewTextView: UIView {
    
    private enum TextMode {
        case beforeWriting
        case write
        
        var placeholder: String? {
            switch self {
            case .beforeWriting:
                return "리뷰를 남겨주세요"
            default:
                return nil
            }
        }
        
        var textColor: UIColor {
            switch self {
            case .beforeWriting:
                return .tertiaryLabel
            case .write:
                return .black
            }
        }
    }
    
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
    private var textMode: TextMode? {
        willSet {
            if let newValue = newValue {
                applyTextViewConfiguration(with: newValue)
            }
        }
    }

    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        configUI()
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
    
    private func configUI() {
        textMode = .beforeWriting
    }
    
    private func applyTextViewConfiguration(with state: TextMode) {
        reviewTextView.textColor = state.textColor
        reviewTextView.text = state.placeholder
    }
}
