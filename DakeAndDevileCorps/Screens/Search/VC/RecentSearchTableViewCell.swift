//
//  RecentSearchTableViewCell.swift
//  DakeAndDevileCorps
//
//  Created by Seungyun Kim on 2022/07/19.
//

import UIKit

class RecentSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var searchedTitle: UILabel!
    
    static let identifier = "RecentSearchTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupCell(title: String) {
        searchedTitle.text = title
    }
    
    @IBAction func deleteData(_ sender: Any) {
    }
}
