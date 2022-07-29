//
//  ReviewPhotoView.swift
//  DakeAndDevileCorps
//
//  Created by Seungyun Kim on 2022/07/29.
//

import UIKit

class ReviewAddPhotoView: UIView {
    
    private enum Size {
        static let cellWidth: CGFloat = UIScreen.main.bounds.size.width
        static let cellHeight: CGFloat = cellWidth
    }
    
    private lazy var addPhotoButton: UIButton = {
        let button = UIButton(type: .custom, primaryAction: UIAction(handler: { _ in
            print("hi")
        }))
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
    
    private let addPhotoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets.zero
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: Size.cellWidth, height: Size.cellHeight)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
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
                                  padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        
        addPhotoButton.widthAnchor.constraint(equalToConstant: 75).isActive = true
        addPhotoButton.heightAnchor.constraint(equalToConstant: 75).isActive = true
    }
}


extension ReviewAddPhotoView:
    UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewPhotoCollectionViewCell.className, for: indexPath) as? ReviewPhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
}

extension ReviewAddPhotoView: UICollectionViewDelegate {
}
