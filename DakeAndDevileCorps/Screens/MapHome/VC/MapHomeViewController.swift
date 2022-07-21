//
//  ViewController.swift
//  DakeAndDevileCorps
//
//  Created by Seungyun Kim on 2022/07/18.
//

import UIKit

class MapHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let categoryView = CategoryView()
        view.addSubview(categoryView)
        categoryView.constraint(categoryView.heightAnchor, constant: 60)
        categoryView.constraint(top: view.safeAreaLayoutGuide.topAnchor,
                                leading: view.leadingAnchor,
                                trailing: view.trailingAnchor,
                                padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        categoryView.backgroundColor = .black
    }
}

