//
//  CategoryCollectionViewCell.swift
//  DakeAndDevileCorps
//
//  Created by SHIN YOON AH on 2022/07/20.
//

import UIKit

final class CategoryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - properties
    
    override var isSelected: Bool {
        didSet {
            applySelectedState(oldValue)
        }
    }
    
    private let backgroundContentView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.backgroundColor = .white
        return view
    }()
    private let itemLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        backgroundContentView.backgroundColor = .white
        itemLabel.textColor = .black
        itemLabel.font = .preferredFont(forTextStyle: .subheadline)
    }
    
    // MARK: - func
    
    private func render() {
        addSubview(backgroundContentView)
        backgroundContentView.constraint(to: self)
        
        backgroundContentView.addSubview(itemLabel)
        itemLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemLabel.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            itemLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 14),
            itemLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -14)
        ])
    }
    
    private func configUI() {
        layer.masksToBounds = false
        
        let cellCornerRadius = (self.bounds.size.width * (self.bounds.size.height / self.bounds.size.width)) / 2
        backgroundContentView.layer.cornerRadius = cellCornerRadius
    }
    
    private func applySelectedState(_ isSelected: Bool) {
        backgroundContentView.backgroundColor = !isSelected ? .black : .white
        itemLabel.textColor = !isSelected ? .white : .black
        itemLabel.font = !isSelected ? .preferredFont(forTextStyle: .subheadline, compatibleWith: .init(legibilityWeight: .bold))
                                    : .preferredFont(forTextStyle: .subheadline)
    }
    
    func setItemLabel(with itemText: String) {
        itemLabel.text = itemText
        itemLabel.sizeToFit()
        layoutIfNeeded()
    }
    
    func setEntryPointView(entryPoint: CategoryEntryPoint) {
        switch entryPoint {
        case .map:
            makeShadow(color: .black,
                       opacity: 0.3,
                       offset: CGSize(width: 0, height: 2),
                       radius: 2)
        case .detail:
            backgroundContentView.layer.borderWidth = 0.5
            backgroundContentView.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
}
