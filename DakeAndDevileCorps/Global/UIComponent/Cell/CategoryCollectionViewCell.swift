//
//  CategoryCollectionViewCell.swift
//  DakeAndDevileCorps
//
//  Created by SHIN YOON AH on 2022/07/20.
//

import UIKit

final class CategoryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - properties
    
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
    public private(set) var isSelectedCell: Bool = false
    
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
        let itemConstraints = itemLabel.constraint(leading: self.leadingAnchor,
                                                   trailing: self.trailingAnchor,
                                                   centerY: self.centerYAnchor,
                                                   padding: UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14))
        itemConstraints[.leading]?.priority = UILayoutPriority(999)
        itemConstraints[.trailing]?.priority = UILayoutPriority(999)
    }
    
    private func configUI() {
        layer.masksToBounds = false
        
        let cellCornerRadius = (self.bounds.size.width * (self.bounds.size.height / self.bounds.size.width)) / 2
        backgroundContentView.layer.cornerRadius = cellCornerRadius
    }
    
    func applySelectedState(_ isSelected: Bool) {
        backgroundContentView.backgroundColor = isSelected ? .zeroMint50 : .white
        itemLabel.textColor = isSelected ? .white : .black
        itemLabel.font = isSelected ? .preferredFont(forTextStyle: .subheadline, compatibleWith: .init(legibilityWeight: .bold))
                                    : .preferredFont(forTextStyle: .subheadline)
        isSelectedCell = isSelected
    }
    
    func setItemLabel(with itemText: String) {
        itemLabel.text = itemText
    }
    
    func setEntryPointView(entryPoint: CategoryEntryPoint) {
        switch entryPoint {
        case .map:
            makeShadow(color: .black,
                       opacity: 0.3,
                       offset: CGSize(width: 0, height: 2),
                       radius: 2)
        default:
            backgroundContentView.layer.borderWidth = 0.5
            backgroundContentView.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
}
