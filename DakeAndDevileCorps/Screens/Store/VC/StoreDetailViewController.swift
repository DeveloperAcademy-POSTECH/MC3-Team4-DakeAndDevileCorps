//
//  StoreViewController.swift
//  DakeAndDevileCorps
//
//  Created by Seungyun Kim on 2022/07/18.
//

import UIKit

enum ProductTableViewCellModel {
    case product(productName: String)
    case item(itemName: String, itemPrice: String)
}

class StoreDetailViewController: UIViewController {
    
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var storeDetailTableView: UITableView!
    var storeInformations: [StoreInformation] = []
    var items: [String : [Item]] = [:]
//    var products: [String] = ["주방세제", " 세탁세제", "섬유유연제", "기타세제", "헤어", "스킨", "바디", "생활", "문구", "애견", "기타"]
//    var productCount: [Int] = []
//    var totalElements: Int = 0
    var section2DataSource = [ProductTableViewCellModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storeDetailTableView.dataSource = self
        storeDetailTableView.delegate = self
        storeDetailTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        storeDetailTableView.rowHeight = UITableView.automaticDimension
        storeDetailTableView.estimatedRowHeight = 100
        
        storeName.text = "알맹상점"
        storeName.font = UIFont.boldSystemFont(ofSize: 22)
        initStoreInformationData()
    }
    
    func initStoreInformationData() {
        storeInformations.append(contentsOf: [
            StoreInformation(imageName: "gamecontroller", content: "서울 마포구 월드컵로25길 47 3층"),
            StoreInformation(imageName: "phone", content: "010-2229-1027")
        ])
        
        items["kitchen detergent"] = [
        Item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
        Item(itemName: "에코띠크 중성 세탁세제", itemPrice: "1g = 7원"),
        Item(itemName: "에코라운드 중성 세탁세제", itemPrice: "1g = 7원"),
        Item(itemName: "강청 무첨가EM세탁물비누", itemPrice: "1g = 10원"),
        Item(itemName: "브라운리브스 세탁세제 (웜코튼향)", itemPrice: "1g = 10원")
        ]
        
        section2DataSource = [
            .product(productName: "주방세제"),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .product(productName: "세탁세제"),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .product(productName: "주방세제"),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .product(productName: "세탁세제"),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .product(productName: "주방세제"),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .product(productName: "세탁세제"),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .product(productName: "주방세제"),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .product(productName: "세탁세제"),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원")
        ]
//
//        for key in items.keys {
//            productCount.append(items[key]?.count ?? 0)
//        }
//        totalElements = productCount.reduce(0, +)
    }
    
}

extension StoreDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "알맹 상점" // custom 필요
        } else {
            return "호롤로"
        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
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
//        operationTimeAndProductCell.setUpOperationTimeAndProductCell()
        
        switch indexPath.section {
        case 0:
            storeInformationCell.setUpperData(isOperation: true)
            storeInformationCell.setBottomData(address: "ddd", phoneNumber: "01040404040", operationTime: "1902939")
            return storeInformationCell
        case 1:
            switch self.section2DataSource[indexPath.row] {
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
        
        
//        if indexPath.section == 0 {
//            storeInformationCell.setUpperData(isOperation: true)
//            storeInformationCell.setBottomData(address: "ddd", phoneNumber: "01040404040", operationTime: "1902939")
//            return storeInformationCell
//        } else {
//            switch self.section2DataSource[indexPath.row] {
//            case let .product(productName):
//                productCell.setData(productName: productName)
//                return productCell
//            case let .item(itemName, itemPrice):
//                itemCell.setData(itemName: itemName, itemPrice: itemPrice)
//                return itemCell
//            default:
//                return UITableViewCell()
//            }
//        }
        
                        
//
//            storeInformationCell.setData(imageName: storeInformations[indexPath.row].imageName, content: storeInformations[indexPath.row].content)
//            return storeInformationCell
//        }
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
