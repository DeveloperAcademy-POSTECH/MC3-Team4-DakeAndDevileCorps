//
//  ItemTableViewCell.swift
//  DakeAndDevileCorps
//
//  Created by 최동권 on 2022/07/19.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    static let identifier = "ItemTableViewCell"
    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(itemName: String, itemPrice: String) {
        self.itemName.text = itemName
        self.itemPrice.text = itemPrice
        self.itemPrice.textColor = .secondaryLabel
    }
}
