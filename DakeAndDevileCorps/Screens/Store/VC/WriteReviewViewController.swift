//
//  WriteReviewViewController.swift
//  DakeAndDevileCorps
//
//  Created by SHIN YOON AH on 2022/07/27.
//

import UIKit

final class WriteReviewViewController: BaseViewController {
    
    // MARK: - properties
    
    private let imagePickerViewController = UIImagePickerController()
    private let photoLimitAlert = UIAlertController(title: "알림", message: "사진은 최대 3장까지 등록할 수 있어요.", preferredStyle: .alert)
    private let addPhotoAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    
    private func initDelegate() {
        imagePickerViewController.delegate = self
        imagePickerViewController.allowsEditing = true
        reviewInputView.reviewAddPhotoView.photoCollectionView.dataSource = self
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
    
    private func setPhotoAlert() {
        let choosePhotoFromAlbumAction = UIAlertAction(title: "앨범에서 선택", style: .default, handler: { [weak self] (action: UIAlertAction) in self?.setImagePickerToPhotoLibrary()})
        let takePhotoAction = UIAlertAction(title: "사진 촬영", style: .default, handler: { [weak self] (action: UIAlertAction) in
            self?.setImagePickerToCamera()
        })
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        let confirmAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        photoLimitAlert.addAction(confirmAction)
        addPhotoAlert.addAction(choosePhotoFromAlbumAction)
        addPhotoAlert.addAction(takePhotoAction)
        addPhotoAlert.addAction(cancelAction)
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
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hidekeyboardWhenTappedAround()
        initDelegate()
        setPhotoAlert()
    }
    
    override func render() {
        view.addSubview(reviewInputView)
        reviewInputView.constraint(top: view.safeAreaLayoutGuide.topAnchor,
                                   leading: view.leadingAnchor,
                                   bottom: view.bottomAnchor,
                                   trailing: view.trailingAnchor,
                                   padding: .zero)
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
        if reviewInputView.reviewAddPhotoView.photoList.count < 3 {
            present(addPhotoAlert, animated: true, completion: nil)
        } else {
            present(photoLimitAlert, animated:  true, completion: nil)
        }
    }
    
    @objc func touchUpInsideToDeletePhoto(sender: UIButton) {
        reviewInputView.reviewAddPhotoView.photoCollectionView.deleteItems(at: [IndexPath(row: sender.tag, section: 0)])
        reviewInputView.reviewAddPhotoView.photoList.remove(at: sender.tag)
    }
}

extension WriteReviewViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            reviewInputView.reviewAddPhotoView.photoList.append(contentsOf: [
                image
            ])
        }
        
        reviewInputView.reviewAddPhotoView.photoCollectionView.reloadData()
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddReviewPhotoCollectionViewCell.className, for: indexPath) as? AddReviewPhotoCollectionViewCell else { return UICollectionViewCell() }
            cell.setupPhotoImageView(to: reviewInputView.reviewAddPhotoView.photoList[indexPath.row])
            cell.deletePhotoButton.tag = indexPath.row
            cell.deletePhotoButton.addTarget(self, action: #selector(touchUpInsideToDeletePhoto(sender:)), for: .touchUpInside)
            return cell
    }
}
