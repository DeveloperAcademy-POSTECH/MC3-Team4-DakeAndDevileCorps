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
        case complete
        
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
            default:
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
        return label
    }()
    private lazy var reviewTextView: UITextView = {
        let textView = UITextView()
        textView.font = .preferredFont(forTextStyle: .subheadline)
        textView.delegate = self
        textView.autocapitalizationType = .none
        textView.autocorrectionType = .no
        textView.spellCheckingType = .no
        return textView
    }()
    private var textMode: TextMode? {
        willSet {
            guard let newValue = newValue,
                  newValue != .complete else { return }
            
            applyTextViewConfiguration(with: newValue)
        }
    }
    private let maxCount = 300
    
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
        setCounter(count: 0)
        textMode = .beforeWriting
    }
    
    private func applyTextViewConfiguration(with state: TextMode) {
        reviewTextView.text = state.placeholder
        reviewTextView.textColor = state.textColor
    }
    
    private func setCounter(count: Int) {
        counterLabel.text = "\(count)/\(maxCount)"
    }
    
    private func checkMaxLength(textView: UITextView, maxLength: Int) {
        guard var textViewText = textView.text else { return }
        let isOverMaxLength = textViewText.count > maxLength
        
        if isOverMaxLength {
            textViewText.removeLast()
            textView.text = textViewText + " "
            rearrangeTextViewText(with: textView, text: textViewText)
        }
    }
    
    private func rearrangeTextViewText(with textView: UITextView, text: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            textView.text = text
            self.setCounter(count: textView.text.count)
        }
    }
}

extension ReviewTextView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        let isBeforeWriting = textMode == .beforeWriting
        if isBeforeWriting {
            textMode = .write
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        let isEmpty = textView.text.isEmpty
        textMode = isEmpty ? .beforeWriting : .complete
    }
    
    func textViewDidChange(_ textView: UITextView) {
        setCounter(count: textView.text?.count ?? 0)
        checkMaxLength(textView: textView, maxLength: maxCount)
    }
}
