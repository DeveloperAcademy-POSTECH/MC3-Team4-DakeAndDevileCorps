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
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleToFill
        return imageView
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
        photoImageView.constraint(to: self)
    }
    
    func setupPhotoImageView(to photo: UIImage) {
        photoImageView.image = photo
    }
}
