//
//  CategoryView.swift
//  DakeAndDevileCorps
//
//  Created by SHIN YOON AH on 2022/07/20.
//

import UIKit

final class CategoryView: UIView {
    
    // MARK: - properties
    
    private let categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 12, left: 20, bottom: 12, right: 20)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - func
    
    private func render() {
        categoryCollectionView.edgesConstraint(to: self)
    }
}
