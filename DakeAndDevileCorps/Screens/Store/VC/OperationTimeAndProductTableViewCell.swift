//
//  OpeerationTimeAndProductTableViewCell.swift
//  DakeAndDevileCorps
//
//  Created by 최동권 on 2022/07/19.
//

import UIKit

class OperationTimeAndProductTableViewCell: UITableViewCell {
    static let identifier = "OperationTimeAndProductTableViewCell"
    @IBOutlet weak var isOperation: UILabel!
    @IBOutlet weak var todayOperationTime: UILabel!
    @IBOutlet weak var products: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
