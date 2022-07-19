//
//  ResultViewController.swift
//  DakeAndDevileCorps
//
//  Created by Seungyun Kim on 2022/07/19.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var resultTableView: UITableView!
    
    var resultList: [StoreModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultTableView.dataSource = self
        initResultData()
    }
    
    func initResultData() {
        resultList.append(contentsOf: [
            StoreModel(storeName: "알맹 상점", storeAddress: "서울 마포구 월드컵로25길 47 3층", distanceToStore: "1.7km"),
            StoreModel(storeName: "더 피커", storeAddress: "서울 마포구 월드컵로25길 47 3층", distanceToStore: "16.2km"),
            StoreModel(storeName: "알맹 상점", storeAddress: "서울 마포구 월드컵로25길 47 3층", distanceToStore: "1.7km"),
            StoreModel(storeName: "더 피커", storeAddress: "서울 마포구 월드컵로25길 47 3층", distanceToStore: "16.2km"),
        ])
    }
}

extension ResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ResultTableViewCell", for: indexPath) as? ResultTableViewCell else { return UITableViewCell()}
        cell.setupCell(title: resultList[indexPath.row].storeName, address: resultList[indexPath.row].storeAddress, distance: resultList[indexPath.row].distanceToStore)
        return cell
    }
}

extension ResultViewController: UITableViewDelegate {
    
}
