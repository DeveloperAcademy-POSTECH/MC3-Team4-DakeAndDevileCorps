//
//  ReviewTableViewCell.swift
//  DakeAndDevileCorps
//
//  Created by 최동권 on 2022/07/27.
//

import UIKit

protocol ReviewTableViewCellDelegate: AnyObject {
    func presentReviewPhotoView(reviewImageNames: [String])
}

class ReviewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var reviewTitleLabel: UILabel!
    @IBOutlet weak var reviewContentLabel: UILabel!
    @IBOutlet weak var reviewImageView: UIImageView!
    
    @IBOutlet weak var reviewStackView: UIStackView!
    @IBOutlet weak var reviewSubStackView: UIStackView!
    @IBOutlet weak var reviewStackTrailingConstraint: NSLayoutConstraint!
    
    private var comment: Comment?
    weak var reviewDelegate: ReviewTableViewCellDelegate?
    
    private let numberOfReviewImageLabel: PaddingLabel = {
        let numberOfReviewImageLabel = PaddingLabel(padding: UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6))
        numberOfReviewImageLabel.translatesAutoresizingMaskIntoConstraints = false
        numberOfReviewImageLabel.font = UIFont.systemFont(ofSize: 11)
        numberOfReviewImageLabel.textColor = .white
        numberOfReviewImageLabel.backgroundColor = .black.withAlphaComponent(0.5)
        numberOfReviewImageLabel.layer.masksToBounds = true
        
        return numberOfReviewImageLabel
    }()
    
    private let categoryLabel: PaddingLabel = {
        let categoryLabel = PaddingLabel(padding: UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8))
        categoryLabel.font = UIFont.systemFont(ofSize: 12)
        categoryLabel.backgroundColor = .systemGray6
        categoryLabel.layer.masksToBounds = true
        categoryLabel.layer.cornerRadius = 4
        
        return categoryLabel
    }()
    
    private let nicknameLabel: UILabel = {
        let nicknameLabel = UILabel()
        nicknameLabel.textColor = .secondaryLabel
        nicknameLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        
        return nicknameLabel
    }()
    
    private let reviewDateLabel: UILabel = {
        let reviewDateLabel = UILabel()
        reviewDateLabel.font = UIFont.systemFont(ofSize: 13)
        
        return reviewDateLabel
    }()
    
    private let reviewImageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
        setupButtonAction()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureUI(comment: Comment) {
        self.comment = comment
        reviewTitleLabel.text = comment.item
        reviewTitleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        
        reviewContentLabel.text = comment.content
        reviewContentLabel.font = UIFont.systemFont(ofSize: 15)
        reviewContentLabel.numberOfLines = 0
        reviewContentLabel.lineBreakMode = .byWordWrapping
        reviewContentLabel.addLabelSpacing(kernValue: 0, lineSpacing: 4)
        
        categoryLabel.text = comment.category
        nicknameLabel.text = comment.nickname
        reviewDateLabel.text = returnAdjustedDate(date: comment.date)
        reviewImageView.image = UIImage(systemName: comment.photo.first ?? "")
        reviewImageView.layer.cornerRadius = 6
        
        if comment.photo.isEmpty {
            numberOfReviewImageLabel.isHidden = true
            reviewStackTrailingConstraint.constant = -72
        } else {
            numberOfReviewImageLabel.text = String(comment.photo.count)
        }
        reviewImageButton.setBackgroundImage(UIImage(named: comment.photo.first ?? ""), for: .normal)
    }
    
    private func returnAdjustedDate(date: String) -> String {
        return date.replacingOccurrences(of: "-", with: ".")
    }
    
    private func setupButtonAction() {
        let reviewImageButtonAction = UIAction { _ in
            self.reviewDelegate?.presentReviewPhotoView(reviewImageNames: self.comment?.photo ?? [])
        }
        reviewImageButton.addAction(reviewImageButtonAction, for: .touchUpInside)
    }
    
    private func setupLayout() {
        reviewSubStackView.addArrangedSubview(nicknameLabel)
        reviewSubStackView.addArrangedSubview(reviewDateLabel)
        reviewStackView.addArrangedSubview(categoryLabel)
        reviewStackView.addArrangedSubview(reviewSubStackView)
        
        addSubview(reviewImageButton)
        NSLayoutConstraint.activate([
            reviewImageButton.topAnchor.constraint(equalTo: topAnchor, constant: 18),
            reviewImageButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            reviewImageButton.widthAnchor.constraint(equalToConstant: 72),
            reviewImageButton.heightAnchor.constraint(equalToConstant: 72)
        ])
        
        addSubview(numberOfReviewImageLabel)
        NSLayoutConstraint.activate([
            numberOfReviewImageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 72),
            numberOfReviewImageLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -28)
        ])
    }
    
    override func draw(_ rect: CGRect) {
        let radius = (numberOfReviewImageLabel.frame.height ) * 0.5
        numberOfReviewImageLabel.layer.cornerRadius = radius
        
        super.draw(rect)
    }
}
