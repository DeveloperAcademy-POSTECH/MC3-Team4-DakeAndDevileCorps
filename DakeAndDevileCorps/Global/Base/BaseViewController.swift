//
//  BaseViewController.swift
//  DakeAndDevileCorps
//
//  Created by Seungyun Kim on 2022/07/18.
//

import UIKit

class BaseViewController: UIViewController {
    
    var storeList: [Store] = []
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        parseStoreData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        render()
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func render() {
        // Override Layout
    }
    
    func configUI() {
        // View Configuration
    }
    
    private func parseStoreData() {
        let storeModel = MockParser.load(type: StoreModel.self, fileName: "Store")
        if let data = storeModel?.data {
            storeList = data
            
            dump(data)
        }
    }
}
