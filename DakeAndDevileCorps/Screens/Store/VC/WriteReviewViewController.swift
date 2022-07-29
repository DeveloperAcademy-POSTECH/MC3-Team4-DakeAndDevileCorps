//
//  WriteReviewViewController.swift
//  DakeAndDevileCorps
//
//  Created by SHIN YOON AH on 2022/07/27.
//

import UIKit

final class WriteReviewViewController: BaseViewController {
    
    // MARK: - properties
    
    let imagePickerViewController = UIImagePickerController()
    
    private func initDelegate() {
        imagePickerViewController.delegate = self
        imagePickerViewController.allowsEditing = true
        reviewInputView.reviewAddPhotoView.photoCollectionView.dataSource = self
        reviewInputView.reviewAddPhotoView.photoCollectionView.delegate = self
        reviewInputView.reviewAddPhotoView.delegate = self
    }
    
    private func setImagePickerToPhotoLibrary() {
        imagePickerViewController.sourceType = .photoLibrary
        present(imagePickerViewController, animated: true)
    }
    
    private func setImagePickerToCamera() {
        imagePickerViewController.sourceType = .camera
        present(imagePickerViewController, animated: true)
    }
    
    private func choosePhotoFromAlbum() {
        present(imagePickerViewController, animated: true)
    }
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        return button
    }()
    private let confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("완료", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.tertiaryLabel, for: .disabled)
        button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        return button
    }()
    private let reviewInputView = ReviewInputView()
    
    
    
    var storeName: String = "알맹상점"
    
    override func render() {
        view.addSubview(reviewInputView)
        reviewInputView.constraint(top: view.safeAreaLayoutGuide.topAnchor,
                                   leading: view.leadingAnchor,
                                   bottom: view.bottomAnchor,
                                   trailing: view.trailingAnchor,
                                   padding: .zero)
        initDelegate()
    }

    override func configUI() {
        setupNavigationBar()
        applyConfirmLabel(with: false)
    }
    
    // MARK: - func
    
    private func setupNavigationBar() {
        let cancelButton = makeBarButtonItem(with: cancelButton)
        let confirmButton = makeBarButtonItem(with: confirmButton)
        
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = confirmButton
        
        let appearance = UINavigationBarAppearance()
        let font = UIFont.preferredFont(forTextStyle: .headline)
        
        appearance.titleTextAttributes = [.font: font]
        title = storeName
    }
    
    private func applyConfirmLabel(with isEnabled: Bool) {
        confirmButton.isEnabled = isEnabled
    }
    
    private func makeBarButtonItem<T: UIView>(with view: T) -> UIBarButtonItem {
        return UIBarButtonItem(customView: view)
    }
}

extension WriteReviewViewController: ReviewAddPhotoDelegate {
    @objc func touchUpInsideToAddPhotoButton() {
        print("Hi")
        imagePickerViewController.sourceType = .photoLibrary
        present(imagePickerViewController, animated: true, completion: nil)
    }
}

extension WriteReviewViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            reviewInputView.reviewAddPhotoView.photoList.append(contentsOf: [
                image
            ])
        }
        
//        setNumberOfPhotos()
        reviewInputView.reviewAddPhotoView.photoCollectionView.reloadData()
        print(reviewInputView.reviewAddPhotoView.photoList.count)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension WriteReviewViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return reviewInputView.reviewAddPhotoView.photoList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:ReviewPhotoCollectionViewCell.className, for: indexPath) as? ReviewPhotoCollectionViewCell else { return UICollectionViewCell() }
            cell.setupPhotoImageView(to: reviewInputView.reviewAddPhotoView.photoList[indexPath.row])
//            cell.setImageConrerRadius()
//            cell.deleteButton.tag = indexPath.row
//            cell.deleteButton.addTarget(self, action: #selector(cancelButtonAction(sender:)), for: .touchUpInside)
            print("setup!")

            return cell
    }
}

extension WriteReviewViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.size.width - 24 * 2 - 100) / 3
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right:  0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
