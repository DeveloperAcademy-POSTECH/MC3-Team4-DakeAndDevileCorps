//
//  SearchViewController.swift
//  DakeAndDevileCorps
//
//  Created by Seungyun Kim on 2022/07/18.
//

import UIKit
import MapKit

class SearchViewController: BaseViewController {
    
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var deleteAllButton: UIButton!
    @IBOutlet weak var tableTitle: UIStackView!
    @IBOutlet weak var tableTitleText: UILabel!
    @IBOutlet weak var nothingView: UIStackView!
    @IBOutlet weak var nothingMessage: UILabel!
    
    let searchBarView: SearchBarView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.entryPoint = .search
        return $0
    }(SearchBarView())
    
    private var filteredStoreList: [Store] = []
    private let keywordCoreData = KeywordManager.shared
    var isResultShowing: Bool = false
    
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
    private let maxCount = 10
    
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
            let recentItemList = keywordCoreData.loadFromCoreData(request: Keywords.fetchRequest())
            hasResult = !recentItemList.isEmpty
        case .result:
            hasResult = !filteredStoreList.isEmpty
        }
        
        nothingView.isHidden = hasResult
        nothingMessage.text = searchType.message
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDelegate()
        setTableResult(searchtype: searchType)
        configureLayout()
    }
    
    private func initDelegate() {
        searchTableView.dataSource = self
        searchTableView.delegate = self
        searchBarView.delegate = self
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
    
    private func saveRecentKeyword() {
        let keyword = searchBarView.text
        let recentItemList = keywordCoreData.loadFromCoreData(request: Keywords.fetchRequest())
        
        checkKeywordItemList(recentItemList, with: keyword)
        keywordCoreData.saveRecentSearch(keyword: keyword)
    }
    
    private func checkKeywordItemList(_ list: [Keywords], with keyword: String) {
        let hasKeyword = list.map({ $0.term }).contains(keyword)
        if hasKeyword {
            keywordCoreData.delete(at: keyword, request: Keywords.fetchRequest())
        }
        
        let recentItemList = keywordCoreData.loadFromCoreData(request: Keywords.fetchRequest())
        let overMaxCount = recentItemList.count >= maxCount
        if overMaxCount {
            keywordCoreData.deleteLast(request: Keywords.fetchRequest())
        }
    }
    
    private func textFieldDidChangeSelection() {
        let keyword = searchBarView.text.removingWhitespaces()
        
        filteredStoreList = storeList.filter({ data -> Bool in
            let storeNameFilter = data.name.removingWhitespaces().lowercased().contains(keyword.lowercased())
            let itemNameFilter = data.items.map({ $0.name }).contains(where: { $0.removingWhitespaces().contains(keyword.lowercased()) })
            let categoryFilter = data.items.map({ $0.category }).contains(where: { $0.removingWhitespaces().contains(keyword.lowercased()) })
            return storeNameFilter || itemNameFilter || categoryFilter
        })
    }
    
    @IBAction func touchUpToDeleteAllSearchedData(_ sender: Any) {
        keywordCoreData.deleteAll(request: Keywords.fetchRequest())
        setNothingView(searchType: .recentSearch)
        searchTableView.reloadData()
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isResultShowing {
            return filteredStoreList.count
        } else {
            let recentItemList = keywordCoreData.loadFromCoreData(request: Keywords.fetchRequest())
            return recentItemList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isResultShowing {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ResultTableViewCell.className, for: indexPath) as? ResultTableViewCell else { return UITableViewCell() }
            cell.setupCell(title: filteredStoreList[indexPath.row].name, address: filteredStoreList[indexPath.row].address, distance: "22.0km")
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RecentSearchTableViewCell.className, for: indexPath) as? RecentSearchTableViewCell else { return UITableViewCell() }
            let recentItemList: [Keywords] = keywordCoreData.loadFromCoreData(request: Keywords.fetchRequest()).reversed()
            cell.setupCell(title: recentItemList[indexPath.row].term)
            cell.didSelectedDeleteButton = { [weak self] in
                let selectedItem = recentItemList[indexPath.row].term
                self?.keywordCoreData.delete(at: selectedItem, request: Keywords.fetchRequest())
                self?.setNothingView(searchType: .recentSearch)
                self?.searchTableView.reloadData()
            }
            return cell
        }
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !isResultShowing {
            let recentItemList = keywordCoreData.loadFromCoreData(request: Keywords.fetchRequest())
            let index = recentItemList.count - indexPath.row - 1
            searchBarView.text = recentItemList[index].term
            didReturnKeyInput()
        } else {
            guard let viewController = UIStoryboard(name: "MapHome", bundle: nil).instantiateViewController(withIdentifier: "ResultMapViewController") as? ResultMapViewController else { return }
            viewController.searchBarView.text = searchBarView.text
            let storeAnnotation = StoreAnnotation(coordinate: CLLocationCoordinate2D(
                latitude: filteredStoreList[indexPath.row].latitude,
                longitude: filteredStoreList[indexPath.row].longitude),
                                                        sellingProductsCategory: [filteredStoreList[indexPath.row].getStoreCategories()], category: .zeroWasteShop, store: filteredStoreList[indexPath.row])
            viewController.shops.append(storeAnnotation)
            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: false) {
                viewController.mapView(viewController.mapView, didSelect: MKAnnotationView(annotation: storeAnnotation, reuseIdentifier: AnnotationView.className))
            }
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
        textFieldDidChangeSelection()
        setTableResult(searchtype: searchType)
        saveRecentKeyword()
        searchTableView.reloadData()
    }
    
    @objc func touchUpInsideLeftButton() {
        let presentingVC = presentingViewController as? MainMapViewController
        presentingVC?.searchBarView.entryPoint = .map
        presentingVC?.searchBarView.text = ""
        dismiss(animated: false)
    }
}
