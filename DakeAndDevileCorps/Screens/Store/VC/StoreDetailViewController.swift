//
//  StoreViewController.swift
//  DakeAndDevileCorps
//
//  Created by Seungyun Kim on 2022/07/18.
//

import UIKit

class StoreDetailViewController: UIViewController {
    
    @IBOutlet weak var storeDetailTableView: UITableView!
    var storeInformations: [StoreInformation] = []
    var items: [Item] = []
    var products: [String] = ["주방세제"]
    override func viewDidLoad() {
        super.viewDidLoad()
        storeDetailTableView.dataSource = self
        storeDetailTableView.delegate = self
        storeDetailTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        storeDetailTableView.rowHeight = 60
        initStoreInformationData()
    }
    
    func initStoreInformationData() {
        storeInformations.append(contentsOf: [
            StoreInformation(imageName: "gamecontroller", content: "서울 마포구 월드컵로25길 47 3층"),
            StoreInformation(imageName: "phone", content: "010-2229-1027")
        ])
        
        items.append(contentsOf: [
        Item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
        Item(itemName: "에코띠크 중성 세탁세제", itemPrice: "1g = 7원"),
        Item(itemName: "에코라운드 중성 세탁세제", itemPrice: "1g = 7원"),
        Item(itemName: "강청 무첨가EM세탁물비누", itemPrice: "1g = 10원"),
        Item(itemName: "브라운리브스 세탁세제 (웜코튼향)", itemPrice: "1g = 10원")
        ])
    }
    
}

extension StoreDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return storeInformations.count
        } else if section == 2 {
            return 1
        } else {
            return items.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let operationTimeAndProductCell = tableView.dequeueReusableCell(
                withIdentifier: OperationTimeAndProductTableViewCell.identifier, for: indexPath
              ) as? OperationTimeAndProductTableViewCell,
              let storeInformationCell = tableView.dequeueReusableCell(
                withIdentifier: StoreInformationTableViewCell.identifier, for: indexPath
              ) as? StoreInformationTableViewCell,
              let productCell = tableView.dequeueReusableCell(
                withIdentifier: ProductCell.identifier, for: indexPath
              ) as? ProductCell,
              let itemCell = tableView.dequeueReusableCell(
                withIdentifier: ItemTableViewCell.identifier, for: indexPath
              ) as? ItemTableViewCell
        else { return UITableViewCell() }
//        operationTimeAndProductCell.setUpOperationTimeAndProductCell()
        
        if indexPath.section == 0 {
            operationTimeAndProductCell.setUpOperationTimeAndProductCell()
            return operationTimeAndProductCell
        } else if indexPath.section == 1 {
            storeInformationCell.setData(imageName: storeInformations[indexPath.row].imageName, content: storeInformations[indexPath.row].content)
            return storeInformationCell
        } else if indexPath.section == 2 {
            productCell.setData(productName: products[indexPath.row])
            return productCell
        } else {
            itemCell.setData(itemName: items[indexPath.row].itemName, itemPrice: items[indexPath.row].itemPrice)
            return itemCell
        }
    }
}

extension StoreDetailViewController: UITableViewDelegate {
  
}
