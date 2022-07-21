//
//  ProductCell.swift
//  DakeAndDevileCorps
//
//  Created by 최동권 on 2022/07/19.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    static let identifier = "ProductTableViewCell"
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var seperateLine: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    func setData(productName: String, isSeperated: Bool) {
        self.productName.text = productName
        self.productName.font = UIFont.boldSystemFont(ofSize: 17)
        seperateLine.isHidden = isSeperated
    }
}
