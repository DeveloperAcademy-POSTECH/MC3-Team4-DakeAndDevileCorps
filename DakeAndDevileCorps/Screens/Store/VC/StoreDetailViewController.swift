//
//  StoreViewController.swift
//  DakeAndDevileCorps
//
//  Created by Seungyun Kim on 2022/07/18.
//

import UIKit

class StoreDetailViewController: UIViewController {
    
    enum ProductTableViewCellModel {
        case product(productName: String, isSeperated: Bool)
        case item(itemName: String, itemPrice: String)
    }
    
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var storeDetailTableView: UITableView!
    
    private var productList = [ProductTableViewCellModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configStoreDetailTableView()
        configStoreName()
        initStoreInformationData()
    }
    
    func configStoreDetailTableView() {
        storeDetailTableView.dataSource = self
        storeDetailTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        storeDetailTableView.rowHeight = UITableView.automaticDimension
        storeDetailTableView.estimatedRowHeight = 100
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
            .product(productName: "주방세제", isSeperated: true),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .product(productName: "세탁세제", isSeperated: false),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .product(productName: "섬유유연제", isSeperated: false),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .product(productName: "기타세제", isSeperated: false),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .product(productName: "헤어", isSeperated: false),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .product(productName: "스킨", isSeperated: false),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .product(productName: "바디", isSeperated: false),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .product(productName: "생활", isSeperated: false),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .product(productName: "문구", isSeperated: false),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .product(productName: "애견", isSeperated: false),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .product(productName: "기타", isSeperated: false),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원")
        ]
    }
}

extension StoreDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    private func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 1:
            return nil // collectionView
        default:
            return nil
        }
    }
    
    private func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 1:
            return 0 // collectionView
        default:
            return 0
        }
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
            
            storeInformationCell.setUpperData(isOperation: true, todayOperationTime: "10:00 ~ 18:00", productCategories: "화장품, 청소용품, 화장품, 식품")
            storeInformationCell.setBottomData(address: "서울 마포구 월드컵로25길 47 3층", phoneNumber: "010-2229-1027", operationTime: "10:00 - 18:00")
            return storeInformationCell
        case 1:
            guard let productCell = tableView.dequeueReusableCell(
                    withIdentifier: ProductTableViewCell.identifier, for: indexPath
                  ) as? ProductTableViewCell,
                  let itemCell = tableView.dequeueReusableCell(
                    withIdentifier: ItemTableViewCell.identifier, for: indexPath
                  ) as? ItemTableViewCell else { return UITableViewCell() }
            
            switch self.productList[indexPath.row] {
            case let .product(productName, isSeperated):
                productCell.setData(productName: productName, isSeperated: isSeperated)
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
