//
//  ItemTableViewCell.swift
//  DakeAndDevileCorps
//
//  Created by 최동권 on 2022/07/19.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    static let identifier = "ItemTableViewCell"
    
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(itemNameLabel: String, itemPriceLabel: String) {
        self.itemNameLabel.text = itemNameLabel
        self.itemPriceLabel.text = itemPriceLabel
        self.itemPriceLabel.textColor = .secondaryLabel
    }
}
