//
//  StoreViewController.swift
//  DakeAndDevileCorps
//
//  Created by Seungyun Kim on 2022/07/18.
//

import UIKit

class StoreDetailViewController: UIViewController {
    
    static let identifier = "StoreDetailViewController"
    
    enum ProductTableViewCellModel: Equatable {
        case product(productName: String)
        case item(itemName: String, itemPrice: String)
    }
    
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var storeDetailTableView: UITableView!
    
    private var productList: [ProductTableViewCellModel] = []
    private var operationList: [String] = []
    private let categoryList: [String] = ["주방세제", "세탁세제", "섬유유연제", "기타세제", "헤어", "스킨", "바디", "식품", "생활", "문구", "애견", "기타"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configStoreDetailTableView()
        configStoreName()
        initStoreInformationData()
    }
    
    func configStoreDetailTableView() {
        storeDetailTableView.dataSource = self
        storeDetailTableView.delegate = self
        storeDetailTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        storeDetailTableView.rowHeight = UITableView.automaticDimension
        storeName.text = "알맹상점"
        storeName.font = UIFont.boldSystemFont(ofSize: 22)
        if #available(iOS 15.0, *) {
            storeDetailTableView.sectionHeaderTopPadding = 0
        }
    }
    
    func configStoreName() {
        storeName.text = "알맹상점"
        storeName.font = UIFont.boldSystemFont(ofSize: 22)
    }
    
    func initStoreInformationData() {
        productList = [
            .product(productName: "주방세제"),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .product(productName: "세탁세제"),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .product(productName: "섬유유연제"),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .product(productName: "기타세제"),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .product(productName: "헤어"),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .product(productName: "스킨"),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .product(productName: "바디"),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .product(productName: "생활"),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .product(productName: "문구"),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .product(productName: "애견"),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .product(productName: "기타"),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원")
        ]
        operationList = ["월 정기 휴일", "화 10:00 ~ 18:00", "수 10:00 ~ 18:00", "목 10:00 ~ 18:00", "금 10:00 ~ 18:00", "토 10:00 ~ 18:00", "일 정기 휴일"]
    }
    
    func scrollToSelectedCategory(indexPath: IndexPath) {
        guard let rowIndex = productList.firstIndex(of: .product(productName: categoryList[indexPath.row])) else { return }
        let indexPath = IndexPath(row: rowIndex, section: 1)
        storeDetailTableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}

extension StoreDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return productList.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let storeInformationCell = tableView.dequeueReusableCell(
                withIdentifier: StoreInformationTableViewCell.identifier, for: indexPath
            ) as? StoreInformationTableViewCell else { return UITableViewCell() }
            
            storeInformationCell.storeInformationDelegate = self
            storeInformationCell.setUpperData(isOperation: true, todayOperationTime: "10:00 ~ 18:00", productCategories: "화장품, 청소용품, 화장품, 식품")
            storeInformationCell.setBottomData(address: "서울 마포구 월드컵로25길 47 3층", phoneNumber: "010-2229-1027", operationTime: "10:00 - 18:00")
            storeInformationCell.setUpperData(isOperation: true,
                                              todayOperationTime: "10:00 ~ 18:00",
                                              productCategories: "화장품, 청소용품, 화장품, 식품")
            storeInformationCell.setBottomData(address: "서울 마포구 월드컵로25길 47 3층",
                                               phoneNumber: "010-2229-1027",
                                               operationTime: "10:00 - 18:00")
            storeInformationCell.setOperationTime(operationList: operationList)
            
            return storeInformationCell
        case 1:
            guard let productCell = tableView.dequeueReusableCell(
                    withIdentifier: ProductTableViewCell.identifier, for: indexPath
                  ) as? ProductTableViewCell,
                  let itemCell = tableView.dequeueReusableCell(
                    withIdentifier: ItemTableViewCell.identifier, for: indexPath
                  ) as? ItemTableViewCell else { return UITableViewCell() }
            
            switch self.productList[indexPath.row] {
            case let .product(productName):
                productCell.setData(productName: productName)
                return productCell
            case let .item(itemName, itemPrice):
                itemCell.setData(itemName: itemName, itemPrice: itemPrice)
                return itemCell
            }
        default:
            return UITableViewCell()
        }
    }
}

extension StoreDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 1:
            let headerView = CategoryView(entryPoint: CategoryEntryPoint.detail)
            headerView.delegate = self
            headerView.backgroundColor = .white
            return headerView
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 1:
            return 60
        default:
            return 0
        }
    }
}

extension StoreDetailViewController: StoreInformationTableViewCellDelegate {
    func requestReload(cell: StoreInformationTableViewCell) {
        storeDetailTableView.reloadData()
    }
}

extension StoreDetailViewController: CategoryCollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        scrollToSelectedCategory(indexPath: indexPath)
    }
}
