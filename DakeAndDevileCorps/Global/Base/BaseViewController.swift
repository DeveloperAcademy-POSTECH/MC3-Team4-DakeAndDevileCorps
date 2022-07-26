//
//  BaseViewController.swift
//  DakeAndDevileCorps
//
//  Created by Seungyun Kim on 2022/07/18.
//

import UIKit

class BaseViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
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
}
