//
//  ResultTableViewCell.swift
//  DakeAndDevileCorps
//
//  Created by Seungyun Kim on 2022/07/19.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

    static let identifier = "ResultTableViewCell"
    
    @IBOutlet weak var storeTitle: UILabel!
    @IBOutlet weak var storeAddress: UILabel!
    @IBOutlet weak var distanceToStore: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(title: String, address: String, distance: String) {
        storeTitle.text = title
        storeAddress.text = address
        distanceToStore.text = distance
    }

}
