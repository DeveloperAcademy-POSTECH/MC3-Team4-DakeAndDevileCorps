//
//  SearchViewController.swift
//  DakeAndDevileCorps
//
//  Created by Seungyun Kim on 2022/07/18.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var deleteAllButton: UIButton!
    @IBOutlet weak var tableTitle: UIStackView!
    @IBOutlet weak var tableTitleText: UILabel!
    @IBOutlet weak var nothingView: UIStackView!
    @IBOutlet weak var nothingMessage: UILabel!
    
    private var recentSearchedItemList: [String] = []
    private var resultList: [StoreModel] = []
    private var isShowingResult: Bool = false
    
    private enum SearchType {
        case recentSearch
        case result(titleString: String)
        
        var title: String {
            switch self {
            case .recentSearch:
                return "최근 검색"
            case .result(let titleString):
                return "'\(titleString)'와 관련 있는 검색 결과"
            }
        }
        
        var message: String {
            switch self {
            case .recentSearch:
                return "최근 검색한 기록이 없습니다."
            case .result:
                return "검색 기록이 없습니다."
            }
        }
    }
    
    private var searchType: SearchType = .recentSearch
    
    private func setTableResult(searchtype: SearchType) {
        setResultTitle(searchType: searchtype)
        setNothingView(searchType: searchtype)
    }
    
    private func setResultTitle(searchType: SearchType) {
        tableTitleText.text = searchType.title
        switch searchType {
        case .result:
            deleteAllButton.isHidden = true
        default:
            deleteAllButton.isHidden = false
        }
    }
    
    private func setNothingView(searchType: SearchType) {
        var hasResult: Bool
        switch searchType {
        case .recentSearch:
            hasResult = !recentSearchedItemList.isEmpty
        case .result:
            hasResult = !resultList.isEmpty
        }
        
        nothingView.isHidden = hasResult
        nothingMessage.text = searchType.message
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDelegate()
        initData()
        setTableResult(searchtype: searchType)
    }
    
    private func initDelegate() {
        searchTableView.dataSource = self
        textField.delegate = self
    }
    
    private func initData() {
        recentSearchedItemList.append(contentsOf: [
            "샴푸", "리필스테이션", "세탁세제", "샴푸", "리필스테이션", "세탁세제", "샴푸", "리필스테이션", "세탁세제", "샴푸", "리필스테이션", "세탁세제"
        ])
        resultList.append(contentsOf: [
            StoreModel(storeName: "알맹 상점", storeAddress: "서울 마포구 월드컵로25길 47 3층", distanceToStore: "1.7km"),
            StoreModel(storeName: "더 피커", storeAddress: "서울 마포구 월드컵로25길 47 3층", distanceToStore: "16.2km"),
            StoreModel(storeName: "알맹 상점", storeAddress: "서울 마포구 월드컵로25길 47 3층", distanceToStore: "1.7km"),
            StoreModel(storeName: "더 피커", storeAddress: "서울 마포구 월드컵로25길 47 3층", distanceToStore: "16.2km")
        ])
    }
    
    @IBAction func touchUpToDeleteAllSearchedData(_ sender: Any) {
        print("delete all!!")
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ResultTableViewCell.className, for: indexPath) as? ResultTableViewCell else { return UITableViewCell() }
            cell.setupCell(title: resultList[indexPath.row].storeName, address: resultList[indexPath.row].storeAddress, distance: resultList[indexPath.row].distanceToStore)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RecentSearchTableViewCell.className, for: indexPath) as? RecentSearchTableViewCell else { return UITableViewCell() }
            cell.setupCell(title: recentSearchedItemList[indexPath.row])
            return cell
        }
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchType = .recentSearch
        isShowingResult = false
        setTableResult(searchtype: searchType)
        searchTableView.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchType = .result(titleString: textField.text ?? "")
        isShowingResult = true
        textField.endEditing(true)
        setTableResult(searchtype: searchType)
        searchTableView.reloadData()
        
        return true
    }
}
