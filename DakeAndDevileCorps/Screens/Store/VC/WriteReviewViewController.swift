//
//  WriteReviewViewController.swift
//  DakeAndDevileCorps
//
//  Created by SHIN YOON AH on 2022/07/27.
//

import UIKit

final class WriteReviewViewController: BaseViewController {
    
    // MARK: - properties
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        return button
    }()
    private let confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("완료", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.tertiaryLabel, for: .disabled)
        button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        return button
    }()
    
    var storeName: String = "알맹상점"

    override func configUI() {
        setupNavigationBar()
        applyConfirmLabel(with: false)
    }
    
    // MARK: - func
    
    private func setupNavigationBar() {
        let cancelButton = makeBarButtonItem(with: cancelButton)
        let confirmButton = makeBarButtonItem(with: confirmButton)
        
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = confirmButton
        
        let appearance = UINavigationBarAppearance()
        let font = UIFont.preferredFont(forTextStyle: .headline)
        
        appearance.titleTextAttributes = [.font: font]
        title = storeName
    }
    
    private func applyConfirmLabel(with isEnabled: Bool) {
        confirmButton.isEnabled = isEnabled
    }
    
    private func makeBarButtonItem<T: UIView>(with view: T) -> UIBarButtonItem {
        return UIBarButtonItem(customView: view)
    }
}
