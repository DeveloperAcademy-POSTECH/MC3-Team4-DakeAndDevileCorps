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

class BasePaddingLabel: UILabel {
    private var padding = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
    
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
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var reviewDateLabel: UILabel!
    @IBOutlet weak var reviewImageView: UIImageView!
    @IBOutlet weak var numberOfReviewImageLabel: UILabel!
    
    @IBOutlet weak var reviewStackView: UIStackView!
    @IBOutlet weak var reviewSubStackView: UIStackView!
    weak var reviewDelegate: ReviewTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setData(reviewModel: ReviewModel) {
        reviewTitleLabel.text = reviewModel.reviewTitle
        reviewTitleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        reviewContentLabel.text = reviewModel.reviewContent
        reviewContentLabel.font = UIFont.systemFont(ofSize: 15)
        reviewContentLabel.numberOfLines = 0
        reviewContentLabel.lineBreakMode = .byWordWrapping
        
        lazy var categoryLabel: BasePaddingLabel = {
            let categoryLabel = BasePaddingLabel(padding: UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8))
            categoryLabel.text = reviewModel.category
            categoryLabel.font = UIFont.systemFont(ofSize: 12)
            categoryLabel.backgroundColor = .systemGray6
            categoryLabel.layer.masksToBounds = true
            categoryLabel.layer.cornerRadius = 4
            
            return categoryLabel
        }()
        lazy var nicknameLabel: UILabel = {
            let nicknameLabel = UILabel()
            nicknameLabel.text = reviewModel.nickname
            nicknameLabel.textColor = .secondaryLabel
            nicknameLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
            
            return nicknameLabel
        }()
        lazy var reviewDateLabel: UILabel = {
            let reviewDateLabel = UILabel()
            reviewDateLabel.text = reviewModel.reviewDate
            reviewDateLabel.font = UIFont.systemFont(ofSize: 13)
            
            return reviewDateLabel
        }()
        
        reviewSubStackView.addArrangedSubview(nicknameLabel)
        reviewSubStackView.addArrangedSubview(reviewDateLabel)
        reviewStackView.addArrangedSubview(categoryLabel)
        reviewStackView.addArrangedSubview(reviewSubStackView)
        
        reviewImageView.image = UIImage(systemName: reviewModel.reviewImageNames?.first ?? "")
        reviewImageView.layer.cornerRadius = 6
        numberOfReviewImageLabel.font = UIFont.systemFont(ofSize: 11)
    }
}
