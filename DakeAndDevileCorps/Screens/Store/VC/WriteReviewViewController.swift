//
//  WriteReviewViewController.swift
//  DakeAndDevileCorps
//
//  Created by SHIN YOON AH on 2022/07/27.
//

import UIKit
import AVFoundation
import Photos

final class WriteReviewViewController: BaseViewController {
    
    // MARK: - properties
    
    var sendComment: ((Comment) -> ())?
    
    private let imagePickerViewController = UIImagePickerController()
    private let photoLimitAlert = UIAlertController(title: "알림", message: "사진은 최대 3장까지 등록할 수 있어요.", preferredStyle: .alert)
    private let addPhotoAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    private let authorizationOfCameraAlert = UIAlertController(title: "알림", message: "Zemap의 카메라  접근이 허용되어 있지 않습니다.", preferredStyle: .alert)
    private let authorizationOfLibraryAlert = UIAlertController(title: "알림", message: "Zemap의 앨범  접근이 허용되어 있지 않습니다.", preferredStyle: .alert)
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
        button.setTitleColor(.zeroMint50, for: .normal)
        button.setTitleColor(.tertiaryLabel, for: .disabled)
        button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        return button
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    private let reviewInputView = ReviewInputView()
    
    var storeName: String = "알맹상점"
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDelegate()
        setPhotoAlert()
        setupNotificationCenter()
        hideKeyboardWhenTappedAround()
    }
    
    override func render() {
        view.addSubview(cancelButton)
        cancelButton.constraint(top: view.topAnchor,
                                leading: view.leadingAnchor,
                                padding: UIEdgeInsets(top: 25, left: 24, bottom: 0, right: 0))
        
        view.addSubview(confirmButton)
        confirmButton.constraint(top: view.topAnchor,
                                 trailing: view.trailingAnchor,
                                 padding: UIEdgeInsets(top: 25, left: 0, bottom: 0, right: 24))
        
        view.addSubview(titleLabel)
        titleLabel.constraint(top: view.topAnchor,
                              centerX: view.centerXAnchor,
                              padding: UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0))
        
        view.addSubview(reviewInputView)
        reviewInputView.constraint(top: titleLabel.bottomAnchor,
                                   leading: view.leadingAnchor,
                                   bottom: view.bottomAnchor,
                                   trailing: view.trailingAnchor,
                                   padding: .zero)
    }

    override func configUI() {
        setupCustomNavigationBar()
        applyConfirmLabel(with: false)
        setupPresentationController()
        setupButtonAction()
    }
    
    // MARK: - func
    
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
        let choosePhotoFromAlbumAction = UIAlertAction(title: "앨범에서 선택", style: .default, handler: { [weak self] _ in self?.checkAlbumPermission()})
        let takePhotoAction = UIAlertAction(title: "사진 촬영", style: .default, handler: { [weak self] _ in
            self?.checkCameraPermission()
        })
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        let confirmAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        let moveToSettingAction = UIAlertAction(title: "설정", style: .default, handler: { _ in
            guard let settingURL = URL(string: UIApplication.openSettingsURLString) else { return }
            UIApplication.shared.open(settingURL)
        })
        photoLimitAlert.addAction(confirmAction)
        addPhotoAlert.addAction(choosePhotoFromAlbumAction)
        addPhotoAlert.addAction(takePhotoAction)
        addPhotoAlert.addAction(cancelAction)
        authorizationOfCameraAlert.addAction(cancelAction)
        authorizationOfCameraAlert.addAction(moveToSettingAction)
        authorizationOfLibraryAlert.addAction(cancelAction)
        authorizationOfLibraryAlert.addAction(moveToSettingAction)
    }
    
    private func setupPresentationController() {
        navigationController?.presentationController?.delegate = self
        isModalInPresentation = true
    }
    
    private func setupCustomNavigationBar() {
        navigationController?.isNavigationBarHidden = true
        titleLabel.text = storeName
    }
    
    private func setupButtonAction() {
        let cancelAction = UIAction { _ in
            self.presentationControllerDidAttemptToDismissAction()
        }
        cancelButton.addAction(cancelAction, for: .touchUpInside)
        let confirmAction = UIAction { _ in
            guard let comment = self.getComment() else { return }
            self.sendComment?(comment)
            self.dismiss(animated: true)
        }
        confirmButton.addAction(confirmAction, for: .touchUpInside)
    }
        
    private func getComment() -> Comment? {
        guard let itemText = reviewInputView.itemTextField.text,
              let content = reviewInputView.reviewTextView.reviewTextView.text
        else { return nil }
        let category = reviewInputView.selectedCategory
        
        return Comment(item: itemText,
                       content: content,
                       category: category,
                       nickname: "스누피",
                       photo: [],
                       date: Date.getCurrentDate(with: "YY-MM-dd"))
    }
    
    private func applyConfirmLabel(with isEnabled: Bool) {
        confirmButton.isEnabled = isEnabled
    }
    
    private func makeBarButtonItem<T: UIView>(with view: T) -> UIBarButtonItem {
        return UIBarButtonItem(customView: view)
    }
    
    private func checkCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
            if granted {
                DispatchQueue.main.async {
                    self.setImagePickerToCamera()
                }
            } else {
                DispatchQueue.main.async {
                    self.present(self.authorizationOfCameraAlert, animated: true, completion: nil)
                }
            }
        })
    }
    
    private func checkAlbumPermission() {
        PHPhotoLibrary.requestAuthorization({ [weak self] status in
            guard let self = self else { return }
            switch status {
            case .authorized:
                DispatchQueue.main.async {
                    self.setImagePickerToPhotoLibrary()
                }
            case .denied:
                DispatchQueue.main.async {
                    self.present(self.authorizationOfLibraryAlert, animated: true, completion: nil)
                }
            default:
                break
            }
        })
    }
    
    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeButtonState), name: .activeReview, object: nil)
    }
    
    private func presentationControllerDidAttemptToDismissAction() {
        guard let isEmptyItemText = reviewInputView.itemTextField.text?.isEmpty else { return }
        let hasCategory = reviewInputView.isSelectedCollection
        let hasItemText = !isEmptyItemText
        let hasContentText = reviewInputView.reviewTextView.textMode != .beforeWriting
        let hasImage = !reviewInputView.reviewAddPhotoView.photoList.isEmpty
        let hasSomething = hasItemText || hasContentText || hasImage || hasCategory
        
        guard hasSomething else {
            dismiss(animated: true, completion: nil)
            return
        }
        
        presentActionSheet()
    }
    
    private func presentActionSheet() {
        let dismissAction: ((UIAlertAction) -> ()) = { [weak self] _ in
            self?.resignFirstResponder()
            self?.dismiss(animated: true, completion: nil)
        }
        makeActionSheet(actionTitles: ["변경 사항 폐기", "취소"],
                        actionStyle: [.destructive, .cancel],
                        actions: [dismissAction, nil])
    }
    
    // MARK: - selector
    
    @objc
    private func didChangeButtonState() {
        confirmButton.isEnabled = reviewInputView.isEssentialButtonFilled()
    }
}

extension WriteReviewViewController: ReviewAddPhotoDelegate {
    @objc func touchUpInsideToAddPhotoButton() {
        if reviewInputView.reviewAddPhotoView.photoList.count < 3 {
            present(addPhotoAlert, animated: true, completion: nil)
        } else {
            present(photoLimitAlert, animated: true, completion: nil)
        }
    }
    
    @objc func touchUpInsideToDeletePhoto(sender: UIButton) {
        reviewInputView.reviewAddPhotoView.photoCollectionView.deleteItems(at: [IndexPath(row: sender.tag, section: 0)])
        reviewInputView.reviewAddPhotoView.photoList.remove(at: sender.tag)
        reviewInputView.reviewAddPhotoView.numberOfPhotosLabel.text = "\(reviewInputView.reviewAddPhotoView.photoList.count)/3"
    }
}

extension WriteReviewViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            reviewInputView.reviewAddPhotoView.photoList.append(contentsOf: [
                image
            ])
        }
        reviewInputView.reviewAddPhotoView.numberOfPhotosLabel.text = "\(reviewInputView.reviewAddPhotoView.photoList.count)/3"
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

// MARK: - UIAdaptivePresentationControllerDelegate
extension WriteReviewViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
        presentationControllerDidAttemptToDismissAction()
    }
}
