//
//  EmptyReviewTableViewCell.swift
//  DakeAndDevileCorps
//
//  Created by 최동권 on 2022/07/31.
//

import UIKit

class EmptyReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var emptyReviewLabel: UILabel!
    weak var delegate: StoreDetailTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configureUI() {
        emptyReviewLabel.text = "리뷰가 아직 없어요."
        delegate?.reloadStoreDetailTableView()
    }
}
