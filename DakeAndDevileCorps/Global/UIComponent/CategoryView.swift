//
//  CategoryView.swift
//  DakeAndDevileCorps
//
//  Created by SHIN YOON AH on 2022/07/20.
//

import UIKit

protocol CategoryCollectionViewDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
}

enum CategoryEntryPoint {
    case map
    case detail
}

final class CategoryView: UIView {
    
    // MARK: - properties
    
    private enum Size {
        static let cellHeight: CGFloat = 36
        static let estimatedtWidth: CGFloat = 10.0
    }
    
    private let categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 12, left: 20, bottom: 12, right: 20)
        layout.estimatedItemSize = CGSize(width: Size.estimatedtWidth, height: Size.cellHeight)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    weak var delegate: CategoryCollectionViewDelegate?
    private var entryPoint: CategoryEntryPoint
    private let categoryList: [String] = ["주방세제", "세탁세제", "섬유유연제", "기타세제", "헤어", "스킨", "바디", "식품", "생활", "문구", "애견", "기타"]
    
    // MARK: - init
    
    init(entryPoint: CategoryEntryPoint) {
        self.entryPoint = entryPoint
        super.init(frame: .zero)
        render()
        configCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - func
    
    private func render() {
        addSubview(categoryCollectionView)
        categoryCollectionView.constraint(to: self)
    }
    
    private func configCollectionView() {
        categoryCollectionView.dataSource = self
        categoryCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.className)
    }
}

extension CategoryView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.className, for: indexPath) as? CategoryCollectionViewCell else { return UICollectionViewCell() }
        cell.setItemLabel(with: categoryList[indexPath.item])
        cell.setEntryPointView(entryPoint: entryPoint)
        return cell
    }
}

extension CategoryView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.collectionView(collectionView, didSelectItemAt: indexPath)
    }
}
