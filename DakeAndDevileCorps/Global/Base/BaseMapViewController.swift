//
//  BaseMapViewController.swift
//  DakeAndDevileCorps
//
//  Created by 김수진 on 2023/01/31.
//

import UIKit

class BaseMapViewController: BaseViewController {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        parseStoreData()
    }
    
    var storeList: [Store] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    private func parseStoreData() {
        let storeModel = MockParser.load(type: StoreModel.self, fileName: "Store")
        if let data = storeModel?.data {
            storeList = data
            
            dump(data)
        }
    }

}
