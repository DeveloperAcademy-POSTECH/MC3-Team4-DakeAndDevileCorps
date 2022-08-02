//
//  CategoryView.swift
//  DakeAndDevileCorps
//
//  Created by SHIN YOON AH on 2022/07/20.
//

import UIKit

@objc protocol CategoryCollectionViewDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    @objc optional func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath)
}

enum CategoryEntryPoint {
    case map
    case detail
    case write
}

final class CategoryView: UIView {
    
    // MARK: - properties
    
    private enum Size {
        static let cellHeight: CGFloat = 36
        static let cellContentInset: CGFloat = 28
    }
    
    private let categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 12, left: 20, bottom: 12, right: 20)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    weak var delegate: CategoryCollectionViewDelegate?
    private var entryPoint: CategoryEntryPoint
    public private(set) var categoryList: [String] = ["세탁세제", "주방세제", "섬유유연제", "기타세제", "헤어", "스킨", "바디", "식품", "생활", "문구", "애견", "기타"]
    
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
        categoryCollectionView.constraint(categoryCollectionView.heightAnchor, constant: 60)
    }
    
    private func configCollectionView() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.className)
    }
    
    private func selectMapDelegateMethod(with isSelected: Bool,
                                         collectionView: UICollectionView,
                                         indexPath: IndexPath) {
        guard entryPoint == .map else { return }
        
        isSelected ?
        delegate?.collectionView(collectionView, didSelectItemAt: indexPath)
        :
        delegate?.collectionView?(collectionView, didDeselectItemAt: indexPath)
    }
    
    private func applySelectedMethod(collectionView: UICollectionView, indexPath: IndexPath) {
        guard entryPoint != .map else { return }
        
        delegate?.collectionView(collectionView, didSelectItemAt: indexPath)
    }
    
    func changeCategoryList(with list: [String]) {
        categoryList = list
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

extension CategoryView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = categoryList[indexPath.item].size(withAttributes: [
            .font : UIFont.preferredFont(forTextStyle: .subheadline)
        ]).width + Size.cellContentInset
        return CGSize(width: width, height: Size.cellHeight)
    }
}

extension CategoryView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell else { return }
        let isSelectedForMap = !cell.isSelectedCell
        let isSelected = cell.isSelected
        let isSelectedAccordingToEntryPoint = (entryPoint == .map) ? isSelectedForMap : isSelected
        
        cell.applySelectedState(isSelectedAccordingToEntryPoint)
        
        applySelectedMethod(collectionView: collectionView, indexPath: indexPath)
        selectMapDelegateMethod(with: isSelectedForMap,
                                collectionView: collectionView,
                                indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell else { return }
        
        cell.applySelectedState(false)
    }
}
