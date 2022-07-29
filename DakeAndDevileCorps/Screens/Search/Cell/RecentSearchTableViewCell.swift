//
//  RecentSearchTableViewCell.swift
//  DakeAndDevileCorps
//
//  Created by Seungyun Kim on 2022/07/19.
//

import UIKit

class RecentSearchTableViewCell: UITableViewCell {

    static let identifier = "RecentSearchTableViewCell"
    
    @IBOutlet weak var searchedTitle: UILabel!
    var didSelectedDeleteButton: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setupCell(title: String) {
        searchedTitle.text = title
    }
    
    @IBAction func touchUpToDeleteData(_ sender: Any) {
        didSelectedDeleteButton?()
    }
}
