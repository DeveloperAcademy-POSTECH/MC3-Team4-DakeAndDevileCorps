//
//  ReviewPhotoView.swift
//  DakeAndDevileCorps
//
//  Created by Seungyun Kim on 2022/07/29.
//

import UIKit

@objc protocol ReviewAddPhotoDelegate {
    @objc optional func touchUpInsideToAddPhotoButton()
}

class ReviewAddPhotoView: UIView {
    
    weak var delegate: ReviewAddPhotoDelegate?
    
    var photoList: [UIImage] = []
    
    private enum Size {
        static let cellWidth: CGFloat = UIScreen.main.bounds.size.width
        static let cellHeight: CGFloat = cellWidth
    }
    
    private lazy var addPhotoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "photo"), for: .normal)
        button.tintColor = .gray
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let photoTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "사진"
        label.textColor = .black
        label.font = .preferredFont(forTextStyle: .headline, compatibleWith: .init(legibilityWeight: .bold))
        return label
    }()
    
    private let numberOfPhotosLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "0/3"
        return label
    }()
    
    let photoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: (UIScreen.main.bounds.size.width - 22 * 2 - 82.5 * 3 - 75) / 3 + 5, bottom: 0, right:  8)
        layout.itemSize = CGSize(width: 75, height: 75)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setAddPhotoButton()
        setupCollectionView()
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func render() {
        addSubview(photoTitleLabel)
        photoTitleLabel.constraint(top: self.topAnchor,
                                   leading: self.leadingAnchor)
        
        addSubview(addPhotoButton)
        addPhotoButton.constraint(top: photoTitleLabel.bottomAnchor,
                                  leading: self.leadingAnchor,
                                  padding: UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0))
        addPhotoButton.widthAnchor.constraint(equalToConstant: 75).isActive = true
        addPhotoButton.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        addSubview(photoCollectionView)
        photoCollectionView.constraint(top: photoTitleLabel.bottomAnchor,
                                       leading: addPhotoButton.trailingAnchor,
                                       trailing: self.trailingAnchor,
                                       padding: UIEdgeInsets(top: 9, left: 0, bottom: 0, right: 0))
        photoCollectionView.widthAnchor.constraint(equalToConstant: 75).isActive = true
        photoCollectionView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func setupCollectionView() {
        photoCollectionView.register(AddReviewPhotoCollectionViewCell.self,
                                     forCellWithReuseIdentifier: AddReviewPhotoCollectionViewCell.className)
    }
    
    private func setAddPhotoButton() {
        addPhotoButton.addTarget(self, action: #selector(touchUpInsideToAddPhotoButton), for: .touchUpInside)
    }
    
    @objc
    private func touchUpInsideToAddPhotoButton() {
        delegate?.touchUpInsideToAddPhotoButton?()
    }

}
