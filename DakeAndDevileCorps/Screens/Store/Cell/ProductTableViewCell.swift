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
    
    func setData(productName: String) {
        self.productNameLabel.text = productName
        self.productNameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        if productName == "주방세제" {
            seperateLineView.isHidden = true
        }
//        seperateLineView.isHidden = isSeperated
    }
}
