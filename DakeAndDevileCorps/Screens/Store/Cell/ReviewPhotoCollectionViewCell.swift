//
//  ReviewPhotoCollectionViewCell.swift
//  DakeAndDevileCorps
//
//  Created by SHIN YOON AH on 2022/07/27.
//

import UIKit

final class ReviewPhotoCollectionViewCell: UICollectionViewCell {
    
    // MARK: - properties
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var deletePhotoButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        photoImageView.image = nil
    }
    
    // MARK: - func
    
    private func render() {
        addSubview(photoImageView)
//        photoImageView.constraint(to: self)
        photoImageView.constraint(top: self.topAnchor,
                                  leading: self.leadingAnchor,
                                  padding: UIEdgeInsets(top: 6, left: 0, bottom: 0, right: 0))
        photoImageView.widthAnchor.constraint(equalToConstant: 75).isActive = true
        photoImageView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        addSubview(deletePhotoButton)
        deletePhotoButton.constraint(top: self.topAnchor,
                                     leading: photoImageView.trailingAnchor,
                                     padding: UIEdgeInsets(top: -2, left: -11, bottom: 0, right: 0))
    }
    
    func setupPhotoImageView(to photo: UIImage) {
        photoImageView.image = photo
    }
}
