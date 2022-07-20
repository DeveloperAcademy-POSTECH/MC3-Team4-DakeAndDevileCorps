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
    @IBOutlet weak var recentSearchedTableTitle: UIStackView!
    @IBOutlet weak var resultTableTitle: UIStackView!
    @IBOutlet weak var nothingMessage: UILabel!
    
    var recentSearchedItemList: [String] = []
    var resultList: [StoreModel] = []
//    var numberOfRows: Int = 10
    var isShowingResult: Bool = true {
        didSet{
            showResultTitle()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recentSearchedTableView.dataSource = self
        initRecentSearchedItem()
        initResultData()
        showResultTitle()
    }

    func initRecentSearchedItem() {
        recentSearchedItemList.append(contentsOf: [
            "샴푸", "리필스테이션", "세탁세제", "샴푸", "리필스테이션", "세탁세제", "샴푸", "리필스테이션", "세탁세제", "샴푸", "리필스테이션", "세탁세제",
        ])
    }
    
    func initResultData() {
        resultList.append(contentsOf: [
            StoreModel(storeName: "알맹 상점", storeAddress: "서울 마포구 월드컵로25길 47 3층", distanceToStore: "1.7km"),
            StoreModel(storeName: "더 피커", storeAddress: "서울 마포구 월드컵로25길 47 3층", distanceToStore: "16.2km"),
            StoreModel(storeName: "알맹 상점", storeAddress: "서울 마포구 월드컵로25길 47 3층", distanceToStore: "1.7km"),
            StoreModel(storeName: "더 피커", storeAddress: "서울 마포구 월드컵로25길 47 3층", distanceToStore: "16.2km"),
        ])
    }
    
    func showResultTitle() {
        if isShowingResult {
            recentSearchedTableTitle.isHidden = true
            resultTableTitle.isHidden = false
            if resultList.count == 0 {
                recentlyNothingView.isHidden = false
                nothingMessage.text = "검색 기록이 없습니다."
            } else {
                recentlyNothingView.isHidden = true
            }
        } else {
            recentSearchedTableTitle.isHidden = false
            resultTableTitle.isHidden = true
            if recentSearchedItemList.count == 0 {
                recentlyNothingView.isHidden = false
                deleteAllButton.isHidden = true
                nothingMessage.text = "최근 검색한 기록이 없습니다."
            } else {
                recentlyNothingView.isHidden = true
            }
        }
    }
    
    @IBAction func searchData(_ sender: Any) {
        isShowingResult.toggle()
        recentSearchedTableView.reloadData()
    }
    
    @IBAction func deleteAllSearchedData(_ sender: Any) {
        
    }
    
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isShowingResult {
            return resultList.count
        } else {
            return recentSearchedItemList.count > 10 ? 10 : recentSearchedItemList.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isShowingResult {
            guard let cell = tableView.dequeueReusableCell(withIdentifier:  "ResultTableViewCell", for: indexPath) as? ResultTableViewCell else { return UITableViewCell()}
            cell.setupCell(title: resultList[indexPath.row].storeName, address: resultList[indexPath.row].storeAddress, distance: resultList[indexPath.row].distanceToStore)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier:  "RecentSearchTableViewCell", for: indexPath) as? RecentSearchTableViewCell else { return UITableViewCell()}
            cell.setupCell(title: recentSearchedItemList[indexPath.row])
            return cell
        }
    }
}

extension SearchViewController: UITableViewDelegate {
    
}
