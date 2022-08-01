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
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
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
    
    let numberOfPhotosLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "0/3"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .gray
        return label
    }()
    
    let photoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: (UIScreen.main.bounds.size.width - (24 + 15) - 76 * 4) / 3, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 83, height: 75)
        
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
        addPhotoButton.constraint(addPhotoButton.widthAnchor, constant: 75)
        addPhotoButton.constraint(addPhotoButton.heightAnchor, constant: 75)
        
        addSubview(numberOfPhotosLabel)
        numberOfPhotosLabel.constraint(top: photoTitleLabel.bottomAnchor,
                                       leading: self.leadingAnchor,
                                       padding: UIEdgeInsets(top: 58, left: 28, bottom: 0, right: 0))
        
        addSubview(photoCollectionView)
        photoCollectionView.constraint(top: photoTitleLabel.bottomAnchor,
                                       leading: addPhotoButton.trailingAnchor,
                                       trailing: self.trailingAnchor,
                                       padding: UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0))
        photoCollectionView.constraint(photoCollectionView.heightAnchor, constant: 100)
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
