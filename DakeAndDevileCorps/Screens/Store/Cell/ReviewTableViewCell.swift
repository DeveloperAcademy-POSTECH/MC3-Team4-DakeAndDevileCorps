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

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var reviewTitleLabel: UILabel!
    @IBOutlet weak var reviewContentLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var reviewDateLabel: UILabel!
    @IBOutlet weak var reviewImageView: UIImageView!
    @IBOutlet weak var numberOfReviewImageLabel: UILabel!
    
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
        reviewContentLabel.text = reviewModel.reviewContent
        reviewContentLabel.numberOfLines = 0
        reviewContentLabel.lineBreakMode = .byClipping
        categoryLabel.text = reviewModel.category
        nicknameLabel.text = reviewModel.nickname
        reviewDateLabel.text = reviewModel.reviewDate
        reviewImageView.image = UIImage(systemName: reviewModel.reviewImageNames?.first ?? "")
    }
}
