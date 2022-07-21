//
//  ViewController.swift
//  DakeAndDevileCorps
//
//  Created by Seungyun Kim on 2022/07/18.
//

import UIKit

class MapHomeViewController: UIViewController {

    // TODO: - 서치바 그림자 그리기
    private let searchBarView: SearchBarView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(SearchBarView())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSearchBarView()
        configureLayout()
    }
    
    private func setSearchBarView() {
        searchBarView.delegate = self
    }

    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(searchBarView)
        NSLayoutConstraint.activate([
            searchBarView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 8),
            searchBarView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            searchBarView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16)
        ])
    }

}

extension MapHomeViewController: SearchBarDelegate {
    @objc func didBeginEditing() {
        view.endEditing(true)
        
        let nextViewController = UIViewController()
        nextViewController.view.backgroundColor = .yellow
        nextViewController.modalTransitionStyle = .crossDissolve
        nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController, animated: true)
    }
}
