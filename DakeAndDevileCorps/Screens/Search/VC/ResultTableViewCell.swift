//
//  ResultTableViewCell.swift
//  DakeAndDevileCorps
//
//  Created by Seungyun Kim on 2022/07/19.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

    @IBOutlet weak var storeTitle: UILabel!
    @IBOutlet weak var storeAddress: UILabel!
    @IBOutlet weak var distanceToStore: UILabel!
    static let identifier = "ResultTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(title: String, address: String, distance: String) {
        storeTitle.text = title
        storeAddress.text = address
        distanceToStore.text = distance
    }

}
