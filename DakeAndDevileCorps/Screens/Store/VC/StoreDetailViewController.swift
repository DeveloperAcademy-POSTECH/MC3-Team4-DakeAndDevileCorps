//
//  StoreViewController.swift
//  DakeAndDevileCorps
//
//  Created by Seungyun Kim on 2022/07/18.
//

import UIKit

enum ProductTableViewCellModel {
    case product(productName: String, isSeperated: Bool)
    case item(itemName: String, itemPrice: String)
}

class StoreDetailViewController: UIViewController {
    
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var storeDetailTableView: UITableView!
    var storeInformations: [StoreInformation] = []
    var section2DataSource = [ProductTableViewCellModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storeDetailTableView.dataSource = self
        storeDetailTableView.delegate = self
        storeDetailTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        storeDetailTableView.rowHeight = UITableView.automaticDimension
        storeDetailTableView.estimatedRowHeight = 100
        if #available(iOS 15.0, *) {
            storeDetailTableView.sectionHeaderTopPadding = 0
        }
        
        storeName.text = "알맹상점"
        storeName.font = UIFont.boldSystemFont(ofSize: 22)
        
        initStoreInformationData()
    }
    
    func initStoreInformationData() {
        section2DataSource = [
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        } else {
            return nil // colletionView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 0 // collcetionView height
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return section2DataSource.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let storeInformationCell = tableView.dequeueReusableCell(
                withIdentifier: StoreInformationTableViewCell.identifier, for: indexPath
              ) as? StoreInformationTableViewCell,
              let productCell = tableView.dequeueReusableCell(
                withIdentifier: ProductTableViewCell.identifier, for: indexPath
              ) as? ProductTableViewCell,
              let itemCell = tableView.dequeueReusableCell(
                withIdentifier: ItemTableViewCell.identifier, for: indexPath
              ) as? ItemTableViewCell
        else { return UITableViewCell() }
        
        switch indexPath.section {
        case 0:
            storeInformationCell.setUpperData(isOperation: true)
            storeInformationCell.setBottomData(address: "ddd", phoneNumber: "01040404040", operationTime: "1902939")
            return storeInformationCell
        case 1:
            switch self.section2DataSource[indexPath.row] {
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

extension StoreDetailViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return dimension
////        switch indexPath.section {
////        case 0:
////            return 200
////        case 1:
////            return 50
////        default:
////            return 0
////        }
//    }
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return uitableviewau
//    }
}
