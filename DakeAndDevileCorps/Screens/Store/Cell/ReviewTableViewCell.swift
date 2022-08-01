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
    
    private let numberOfReviewImageLabel: PaddingLabel = {
        let numberOfReviewImageLabel = PaddingLabel(padding: UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6))
        numberOfReviewImageLabel.translatesAutoresizingMaskIntoConstraints = false
        numberOfReviewImageLabel.font = UIFont.systemFont(ofSize: 11)
        numberOfReviewImageLabel.textColor = .white
        numberOfReviewImageLabel.backgroundColor = .gray
        numberOfReviewImageLabel.layer.masksToBounds = true
        numberOfReviewImageLabel.layer.opacity = 0.5
        
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
    
    private var reviewModel: ReviewModel?
    weak var reviewDelegate: ReviewTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
        setupButtonAction()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureUI(reviewModel: ReviewModel) {
        self.reviewModel = reviewModel
        reviewTitleLabel.text = reviewModel.title
        reviewTitleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        
        reviewContentLabel.text = reviewModel.content
        reviewContentLabel.font = UIFont.systemFont(ofSize: 15)
        reviewContentLabel.numberOfLines = 0
        reviewContentLabel.lineBreakMode = .byWordWrapping
        
        categoryLabel.text = reviewModel.category
        nicknameLabel.text = reviewModel.nickname
        reviewDateLabel.text = reviewModel.date
        
        reviewImageView.image = UIImage(systemName: reviewModel.photos.first ?? "")
        reviewImageView.layer.cornerRadius = 6
        
        if reviewModel.photos.isEmpty {
            numberOfReviewImageLabel.isHidden = true
        } else {
            numberOfReviewImageLabel.text = String(reviewModel.photos.count)
        }
        reviewImageButton.setBackgroundImage(UIImage(systemName: reviewModel.photos.first ?? ""), for: .normal)
    }
    
    private func setupButtonAction() {
        let reviewImageButtonAction = UIAction { _ in
            self.reviewDelegate?.presentReviewPhotoView(reviewImageNames: self.reviewModel?.photos ?? [])
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
