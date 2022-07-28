//
//  SearchViewController.swift
//  DakeAndDevileCorps
//
//  Created by Seungyun Kim on 2022/07/18.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var deleteAllButton: UIButton!
    @IBOutlet weak var tableTitle: UIStackView!
    @IBOutlet weak var tableTitleText: UILabel!
    @IBOutlet weak var nothingView: UIStackView!
    @IBOutlet weak var nothingMessage: UILabel!
    
    private let searchBarView: SearchBarView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.entryPoint = .search
        return $0
    }(SearchBarView())
    
    private var recentSearchedItemList: [String] = []
    private var resultList: [StoreModel] = []
    private var isResultShowing: Bool = false
    
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
        configureLayout()
    }
    
    private func initDelegate() {
        searchTableView.dataSource = self
        searchTableView.delegate = self
        searchBarView.delegate = self
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
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(searchBarView)
        NSLayoutConstraint.activate([
            searchBarView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 8),
            searchBarView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            searchBarView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16)
        ])
    }
    
    @IBAction func touchUpToDeleteAllSearchedData(_ sender: Any) {
        print("delete all!!")
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isResultShowing {
            return resultList.count
        } else {
            return recentSearchedItemList.count > 10 ? 10 : recentSearchedItemList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isResultShowing {
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

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !isResultShowing {
            searchBarView.text = recentSearchedItemList[indexPath.row]
            didReturnKeyInput()
        }
    }
}

extension SearchViewController: SearchBarDelegate {
    @objc func didBeginEditing() {
        searchType = .recentSearch
        isResultShowing = false
        setTableResult(searchtype: searchType)
        searchTableView.reloadData()
    }
    
    @objc func didReturnKeyInput() {
        searchType = .result(titleString: searchBarView.text)
        isResultShowing = true
        view.endEditing(true)
        setTableResult(searchtype: searchType)
        searchTableView.reloadData()
    }
}
