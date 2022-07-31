//
//  AddReviewPhotoCollectionViewCell.swift
//  DakeAndDevileCorps
//
//  Created by Seungyun Kim on 2022/07/30.
//

import UIKit

final class AddReviewPhotoCollectionViewCell: UICollectionViewCell {
    
    // MARK: - properties
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let deletePhotoButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .black
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
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
        photoImageView.constraint(top: self.topAnchor,
                                  leading: self.leadingAnchor,
                                  padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        photoImageView.constraint(photoImageView.widthAnchor, constant: 75)
        photoImageView.constraint(photoImageView.heightAnchor, constant: 75)
        
        addSubview(deletePhotoButton)
        deletePhotoButton.constraint(top: self.topAnchor,
                                     leading: photoImageView.trailingAnchor,
                                     padding: UIEdgeInsets(top: -8, left: -23, bottom: 0, right: 0))
    }
    
    func setupPhotoImageView(to photo: UIImage) {
        photoImageView.image = photo
    }
}
