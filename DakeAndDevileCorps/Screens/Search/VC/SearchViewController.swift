//
//  SearchViewController.swift
//  DakeAndDevileCorps
//
//  Created by Seungyun Kim on 2022/07/18.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var recentSearchedTableView: UITableView!
    
    var recentSearchedItemList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recentSearchedTableView.dataSource = self
        initRecentSearchedItem()
    }

    func initRecentSearchedItem() {
        recentSearchedItemList.append(contentsOf: [
            "샴푸", "리필스테이션", "세탁세제"
        ])
    }

}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentSearchedItemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:  "RecentSearchTableViewCell", for: indexPath) as? RecentSearchTableViewCell else { return UITableViewCell()}
        cell.setupCell(title: recentSearchedItemList[indexPath.row])
        return cell
    }
    
    
}

extension SearchViewController: UITableViewDelegate {
    
}
