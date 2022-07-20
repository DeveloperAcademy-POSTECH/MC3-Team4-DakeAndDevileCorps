//
//  SearchViewController.swift
//  DakeAndDevileCorps
//
//  Created by Seungyun Kim on 2022/07/18.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var recentSearchedTableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var recentlyNothingView: UIStackView!
    @IBOutlet weak var deleteAllButton: UIButton!
    
    var recentSearchedItemList: [String] = []
    var numberOfRows: Int = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recentSearchedTableView.dataSource = self
        initRecentSearchedItem()
        showRecentlyNothing()
    }

    func initRecentSearchedItem() {
        recentSearchedItemList.append(contentsOf: [
            "샴푸", "리필스테이션", "세탁세제", "샴푸", "리필스테이션", "세탁세제", "샴푸", "리필스테이션", "세탁세제", "샴푸", "리필스테이션", "세탁세제",
        ])
    }
    
    func showRecentlyNothing() {
        if recentSearchedItemList.count == 0 {
            recentlyNothingView.isHidden = false
            deleteAllButton.isHidden = true
        } else {
            recentlyNothingView.isHidden = true
        }
    }
    
    @IBAction func searchData(_ sender: Any) {
        
    }
    
    @IBAction func deleteAllSearchedData(_ sender: Any) {
        
    }
    
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:  "RecentSearchTableViewCell", for: indexPath) as? RecentSearchTableViewCell else { return UITableViewCell()}
        cell.setupCell(title: recentSearchedItemList[indexPath.row])
        return cell
    }
    
    
}

extension SearchViewController: UITableViewDelegate {
    
}
