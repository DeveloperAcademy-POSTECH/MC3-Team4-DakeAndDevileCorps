//
//  ProductCell.swift
//  DakeAndDevileCorps
//
//  Created by 최동권 on 2022/07/19.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var seperateLineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        seperateLineView.isHidden = false
    }
    
    func setData(productName: String) {
        self.productNameLabel.text = productName
        self.productNameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        if productName == "세탁세제" {
            seperateLineView.isHidden = true
        }
    }
}
