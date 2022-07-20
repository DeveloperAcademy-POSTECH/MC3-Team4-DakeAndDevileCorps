//
//  StoreInformationTableViewCell.swift
//  DakeAndDevileCorps
//
//  Created by 최동권 on 2022/07/19.
//

import UIKit

class StoreInformationTableViewCell: UITableViewCell {
    static let identifier = "StoreInformationTableViewCell"
    
    @IBOutlet weak var informationImage: UIImageView!
    @IBOutlet weak var informationContent: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setData(imageName: String, content: String) {
        informationImage.image = UIImage(systemName: imageName)
        informationContent.text = content
    }
}
