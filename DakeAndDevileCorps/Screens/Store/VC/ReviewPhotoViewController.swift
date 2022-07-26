//
//  ReviewPhotoViewController.swift
//  DakeAndDevileCorps
//
//  Created by SHIN YOON AH on 2022/07/26.
//

import UIKit

final class ReviewPhotoViewController: BaseViewController {
    
    private enum Size {
        static let cellWidth: CGFloat = UIScreen.main.bounds.size.width
        static let cellHeight: CGFloat = cellWidth
    }

    // MARK: - properties
    
    private let xmarkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        return button
    }()
    private let scrollIndexLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline, compatibleWith: .init(legibilityWeight: .bold))
        label.textColor = .white
        label.text = "1/3"
        return label
    }()
    private let photoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets.zero
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: Size.cellWidth, height: Size.cellHeight)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    var dummyPhotos: [UIImage?] = [UIImage(systemName: "moon.fill"),
                                   UIImage(systemName: "sun.min"),
                                   UIImage(systemName: "sun.max")]
    
    override func configUI() {
        view.backgroundColor = .black
        setupCollectionView()
    }
    
    override func render() {
        view.addSubview(xmarkButton)
        xmarkButton.constraint(top: view.safeAreaLayoutGuide.topAnchor,
                               leading: view.leadingAnchor,
                               padding: UIEdgeInsets(top: 16, left: 24, bottom: 0, right: 0))
        
        view.addSubview(scrollIndexLabel)
        scrollIndexLabel.constraint(top: view.safeAreaLayoutGuide.topAnchor,
                                    centerX: view.centerXAnchor,
                                    padding: UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0))
        
        view.addSubview(photoCollectionView)
        photoCollectionView.constraint(leading: view.leadingAnchor,
                                       trailing: view.trailingAnchor,
                                       centerX: view.centerXAnchor,
                                       centerY: view.centerYAnchor)
        photoCollectionView.constraint(photoCollectionView.heightAnchor, constant: Size.cellWidth)
    }
    
    // MARK: - func
    
    private func setupCollectionView() {
        photoCollectionView.dataSource = self
        photoCollectionView.register(ReviewPhotoCollectionViewCell.self,
                                     forCellWithReuseIdentifier: ReviewPhotoCollectionViewCell.className)
    }
}

extension ReviewPhotoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummyPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewPhotoCollectionViewCell.className, for: indexPath) as? ReviewPhotoCollectionViewCell else { return UICollectionViewCell() }
        if let photo = dummyPhotos[indexPath.item] {
            cell.setupPhotoImageView(to: photo)
        }
        return cell
    }
}
