//
//  StoreViewController.swift
//  DakeAndDevileCorps
//
//  Created by Seungyun Kim on 2022/07/18.
//

import UIKit

protocol StoreDetailViewControllerDelegate: AnyObject {
    func setupButtonAction(closeButton: UIButton)
    func setupViewWillDisappear(closeButton: UIButton)
}

// TODO: - storeList 사용 때문에 BaseMapViewController 상속 -> 개선 필요
class StoreDetailViewController: BaseMapViewController {
    
    // MARK: - properties
    private enum SectionType: Int, CaseIterable {
        case storeInformation = 0
        case itemInformation = 1
    }
    
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var storeDetailTableView: UITableView!
    @IBOutlet weak var closeStoreDetailButton: UIButton!
    private var productList: [ProductTableViewCellModel] = []
    private var filteredCategoryList: [String] = []
    private var commentList: [Comment] = []
    private var selectHeader = StoreDetailSelectView()
    private var categoryHeader = CategoryView(entryPoint: .detail)
    private var itemInformationType: ItemInformationType = .productList
    private var store: Store?
    var dataIndex: Int = 4
    var numberOfCategory: Int = 0
    weak var delegate: StoreDetailViewControllerDelegate?
    
    // MARK: - func
    
    override func viewDidLoad() {
        super.viewDidLoad()
        store = storeList[dataIndex]
        configStoreDetailTableView()
        initStoreInformationData()
        configHeader()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.setupViewWillDisappear(closeButton: closeStoreDetailButton)
    }
    
    @IBAction func closeStoreDetail(_ sender: Any) {
        delegate?.setupButtonAction(closeButton: closeStoreDetailButton)
    }
    
    private func configStoreDetailTableView() {
        storeDetailTableView.dataSource = self
        storeDetailTableView.delegate = self
        storeDetailTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        storeName.text = store?.name
        storeName.font = UIFont.boldSystemFont(ofSize: 22)
        if #available(iOS 15.0, *) {
            storeDetailTableView.sectionHeaderTopPadding = 0
        }
    }
    
    private func configHeader() {
        selectHeader.delegate = self
        selectHeader.backgroundColor = .white
        categoryHeader.delegate = self
        categoryHeader.backgroundColor = .white
    }
    
    private func initStoreInformationData() {
        let itemList = store?.items ?? []
        
        itemList.forEach({ item in
            if itemList.first(where: { $0.category == item.category }) == item {
                numberOfCategory += 1
                productList.append(.product(productName: item.category))
                filteredCategoryList.append(item.category)
            }
            productList.append(.item(itemName: item.name))
        })
        commentList = store?.comments ?? []
        categoryHeader.changeCategoryList(with: filteredCategoryList)
    }
    
    private func scrollToSelectedCategory(indexPath: IndexPath) {
        guard let rowIndex = productList.firstIndex(of: .product(productName: filteredCategoryList[indexPath.row])) else { return }
        let indexPath = IndexPath(row: rowIndex, section: 1)
        storeDetailTableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}

// MARK: - extensions

extension StoreDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionType = SectionType(rawValue: section) else { return 0 }
        switch (sectionType, itemInformationType) {
        case (.storeInformation, _):
            return 1
        case (.itemInformation, .productList):
            return productList.count
        case (.itemInformation, .reviewList):
            return commentList.isEmpty ? 1 : commentList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionType = SectionType(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch (sectionType, itemInformationType) {
        case (.storeInformation, _):
            return returnStoreInformationCell(tableView, indexPath: indexPath)
        case (.itemInformation, .productList):
            return returnProductCell(tableView, indexPath: indexPath)
        case (.itemInformation, .reviewList):
            return returnReviewCell(tableView, indexPath: indexPath)
        }
    }
    
    private func returnStoreInformationCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let storeInformationCell = tableView.dequeueReusableCell(
            withIdentifier: StoreInformationTableViewCell.className, for: indexPath
        ) as? StoreInformationTableViewCell else { return UITableViewCell() }
        
        storeInformationCell.selectionStyle = .none
        storeInformationCell.storeInformationDelegate = self
        if store?.getTodayOfficeHour() == "정기휴무" {
            storeInformationCell.setUpperData(todayOperationTime: "",
                                              productCategories: store?.getStoreCategories())
            storeInformationCell.setBetweenDot()
        } else {
            storeInformationCell.setUpperData(todayOperationTime: store?.getTodayOfficeHour(),
                                              productCategories: store?.getStoreCategories())
        }
        storeInformationCell.setBottomData(address: store?.address,
                                           phoneNumber: store?.telephone)
        storeInformationCell.setOperationTime(operationList: store?.officeHour)
        storeInformationCell.setOperationStatusLabel(with: store)
        
        return storeInformationCell
    }
    
    private func returnProductCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let productCell = tableView.dequeueReusableCell(
            withIdentifier: ProductTableViewCell.className, for: indexPath
        ) as? ProductTableViewCell,
              let itemCell = tableView.dequeueReusableCell(
                withIdentifier: ItemTableViewCell.className, for: indexPath
              ) as? ItemTableViewCell else { return UITableViewCell() }
        
        switch self.productList[indexPath.row] {
        case let .product(productName):
            productCell.selectionStyle = .none
            productCell.setData(productName: productName)
            return productCell
        case let .item(itemName):
            itemCell.selectionStyle = .none
            itemCell.setData(itemName: itemName)
            return itemCell
        }
    }
    
    private func returnReviewCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        if commentList.isEmpty {
            guard let emptyReviewCell = tableView.dequeueReusableCell(withIdentifier: EmptyReviewTableViewCell.className) as? EmptyReviewTableViewCell else { return UITableViewCell() }
            emptyReviewCell.configureUI()
            emptyReviewCell.selectionStyle = .none
            
            return emptyReviewCell
        } else {
            guard let reviewCell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.className, for: indexPath) as? ReviewTableViewCell else { return UITableViewCell() }
            reviewCell.selectionStyle = .none
            reviewCell.configureUI(comment: commentList[indexPath.row])
            reviewCell.reviewDelegate = self
            
            return reviewCell
        }
    }
}

extension StoreDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionType = SectionType(rawValue: section) else { return UIView() }
        
        let stackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            
            return stackView
        }()
        
        stackView.addArrangedSubview(selectHeader)
        
        switch (sectionType, itemInformationType) {
        case (.itemInformation, .productList):
            stackView.addArrangedSubview(categoryHeader)
            
            NSLayoutConstraint.activate([
                selectHeader.heightAnchor.constraint(equalToConstant: 60),
                categoryHeader.heightAnchor.constraint(equalToConstant: 60)
            ])
            return stackView
        case (.itemInformation, .reviewList):
            return stackView
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let sectionType = SectionType(rawValue: section) else { return CGFloat() }
        switch (sectionType, itemInformationType) {
        case (.itemInformation, .productList):
            return 120
        case (.itemInformation, .reviewList):
            return 60
        default:
            return 0
        }
    }
}

extension StoreDetailViewController: StoreDetailTableViewCellDelegate {
    func reloadStoreDetailTableView() {
        storeDetailTableView.reloadData()
    }
}

extension StoreDetailViewController: CategoryCollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        scrollToSelectedCategory(indexPath: indexPath)
    }
}

extension StoreDetailViewController: ReviewTableViewCellDelegate {
    func presentReviewPhotoView(reviewImageNames: [String]) {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: ReviewPhotoViewController.className) as? ReviewPhotoViewController else { return }
        viewController.setData(reviewImageNames: reviewImageNames)
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true, completion: nil)
        
    }
}

extension StoreDetailViewController: StoreDetailSelectViewDelegate {
    func didSelectedButton(_ storeDetailSelectView: StoreDetailSelectView, isReviewButton: Bool, itemInformationType: ItemInformationType) {
        self.itemInformationType = itemInformationType
        
        storeDetailSelectView.iteminformationType = itemInformationType
        storeDetailSelectView.applyShowingState()
        storeDetailSelectView.productButtonBottomBar.isHidden = itemInformationType.isHiddenProductButtonBottomBar
        storeDetailSelectView.reviewButtonBottomBar.isHidden = itemInformationType.isHiddenReviewButtonBottomBar
        storeDetailTableView.reloadData()
    }
    
    func didTappedWriteReviewButton() {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "WriteReviewNavigationController") as? UINavigationController,
              let presentViewController = viewController.viewControllers.first as? WriteReviewViewController
        else { return }
        
        presentViewController.sendComment = { [weak self] comment in
            self?.commentList.insert(comment, at: 0)
            self?.storeDetailTableView.reloadData()
            self?.updateListCountOfButton(self?.selectHeader ?? StoreDetailSelectView())
        }
        
        present(viewController, animated: true, completion: nil)
    }
    
    func updateListCountOfButton(_ storeDetailSelectView: StoreDetailSelectView) {
        storeDetailSelectView.numberOfReviews = commentList.count
        storeDetailSelectView.numberOfProducts = productList.count - numberOfCategory
    }
}
