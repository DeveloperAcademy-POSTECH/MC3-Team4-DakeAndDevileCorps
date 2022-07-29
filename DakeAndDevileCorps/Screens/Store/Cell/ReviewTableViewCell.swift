//
//  ReviewTableViewCell.swift
//  DakeAndDevileCorps
//
//  Created by 최동권 on 2022/07/27.
//

import UIKit

protocol ReviewTableViewCellDelegate: AnyObject {
    func requestReviewTableViewCellReload()
}

class PaddingLabel: UILabel {
    private var padding = UIEdgeInsets()
    
    convenience init(padding: UIEdgeInsets) {
        self.init()
        self.padding = padding
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        
        return contentSize
    }
}

class ReviewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var reviewTitleLabel: UILabel!
    @IBOutlet weak var reviewContentLabel: UILabel!
    @IBOutlet weak var reviewImageView: UIImageView!
    
    @IBOutlet weak var reviewStackView: UIStackView!
    @IBOutlet weak var reviewSubStackView: UIStackView!
    weak var reviewDelegate: ReviewTableViewCellDelegate?
    
    lazy var numberOfReviewImageLabel: PaddingLabel? = PaddingLabel()
    lazy var categoryLabel: UILabel = UILabel()
    lazy var nicknameLabel: UILabel = UILabel()
    lazy var reviewDateLabel: UILabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        render()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(reviewModel: ReviewModel) {
        reviewTitleLabel.text = reviewModel.reviewTitle
        reviewTitleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        reviewContentLabel.text = reviewModel.reviewContent
        reviewContentLabel.font = UIFont.systemFont(ofSize: 15)
        reviewContentLabel.numberOfLines = 0
        reviewContentLabel.lineBreakMode = .byWordWrapping
        categoryLabel.text = reviewModel.category
        nicknameLabel.text = reviewModel.nickname
        reviewDateLabel.text = reviewModel.reviewDate
        
        if let reviewImageName = reviewModel.reviewImageNames {
            reviewImageView.image = UIImage(systemName: reviewImageName.first ?? "")
            reviewImageView.layer.cornerRadius = 6
            numberOfReviewImageLabel?.text = String(reviewImageName.count )
            self.numberOfReviewImageLabel = numberOfReviewImageLabel
        } else {
            numberOfReviewImageLabel?.isHidden = true
        }
    }
    
    private func render() {
        lazy var numberOfReviewImageLabel: PaddingLabel = {
            let numberOfReviewImageLabel = PaddingLabel(padding: UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6))
            numberOfReviewImageLabel.translatesAutoresizingMaskIntoConstraints = false
            numberOfReviewImageLabel.font = UIFont.systemFont(ofSize: 11)
            numberOfReviewImageLabel.textColor = .white
            numberOfReviewImageLabel.backgroundColor = .gray
            numberOfReviewImageLabel.layer.masksToBounds = true
            numberOfReviewImageLabel.layer.opacity = 0.5

            return numberOfReviewImageLabel
        }()
                
        lazy var categoryLabel: PaddingLabel = {
            let categoryLabel = PaddingLabel(padding: UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8))
            categoryLabel.font = UIFont.systemFont(ofSize: 12)
            categoryLabel.backgroundColor = .systemGray6
            categoryLabel.layer.masksToBounds = true
            categoryLabel.layer.cornerRadius = 4
            
            return categoryLabel
        }()
        
        lazy var nicknameLabel: UILabel = {
            let nicknameLabel = UILabel()
            nicknameLabel.textColor = .secondaryLabel
            nicknameLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
            
            return nicknameLabel
        }()
        
        lazy var reviewDateLabel: UILabel = {
            let reviewDateLabel = UILabel()
            reviewDateLabel.font = UIFont.systemFont(ofSize: 13)
            
            return reviewDateLabel
        }()
        
        self.categoryLabel = categoryLabel
        self.nicknameLabel = nicknameLabel
        self.reviewDateLabel = reviewDateLabel
        self.numberOfReviewImageLabel = numberOfReviewImageLabel
        
        reviewSubStackView.addArrangedSubview(nicknameLabel)
        reviewSubStackView.addArrangedSubview(reviewDateLabel)
        reviewStackView.addArrangedSubview(categoryLabel)
        reviewStackView.addArrangedSubview(reviewSubStackView)
        addSubview(numberOfReviewImageLabel)
        NSLayoutConstraint.activate([
            numberOfReviewImageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 72),
            numberOfReviewImageLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -28)
        ])
    }
    
    override func draw(_ rect: CGRect) {
        let radius = (numberOfReviewImageLabel?.frame.height ?? 0) * 0.5
        numberOfReviewImageLabel?.layer.cornerRadius = radius

        super.draw(rect)
    }
}
