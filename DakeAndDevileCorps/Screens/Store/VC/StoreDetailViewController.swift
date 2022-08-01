//
//  StoreViewController.swift
//  DakeAndDevileCorps
//
//  Created by Seungyun Kim on 2022/07/18.
//

import UIKit

class StoreDetailViewController: BaseViewController {
    
    // MARK: - properties
    private enum SectionType: Int, CaseIterable {
        case storeInformation = 0
        case itemInformation = 1
    }
    
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var storeDetailTableView: UITableView!
    @IBOutlet weak var closeStoreDetailButton: UIButton!
    
    private var productList: [ProductTableViewCellModel] = []
    private let categoryList: [String] = ["주방세제", "세탁세제", "섬유유연제", "기타세제", "헤어", "스킨", "바디", "식품", "생활", "문구", "애견", "기타"]
    private var reviewList: [ReviewModel] = []
    private var selectHeader = StoreDetailSelectView()
    private var categoryHeader = CategoryView(entryPoint: .detail)
    private var itemInformationType: ItemInformationType = .productList
    private var store: Store?
    var dataIndex: Int = 0
    
    // MARK: - func
    
    override func viewDidLoad() {
        super.viewDidLoad()
        store = storeList[dataIndex]
        configStoreDetailTableView()
        initStoreInformationData()
        configHeader()
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
        productList = [
            .product(productName: "주방세제"),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .product(productName: "세탁세제"),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .product(productName: "섬유유연제"),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .product(productName: "기타세제"),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .product(productName: "헤어"),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .product(productName: "스킨"),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .product(productName: "바디"),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .product(productName: "생활"),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .product(productName: "문구"),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .product(productName: "애견"),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원"),
            .product(productName: "기타"),
            .item(itemName: "인블리스 세탁세제", itemPrice: "1g = 4원")
        ]
        
        reviewList.append(contentsOf: [
            ReviewModel(title: "인블리스 세탁세제", content: "좋습니다. 벌써 3번 리필했어요!", category: "세탁세제", nickname: "냥냥이", date: "21.7.18", photos: ["star.fill", "moon.fill", "sun.max.fill"]),
            ReviewModel(title: "에코라운드 중성 주방세제", content: "최고네용~ 캬캬캬 한 번 더 리필할 듯 싶습니다. 향이 짱 좋고 세척력도 넘넘 좋아요! 추천추천합니다ㅎㅎ", category: "주방세제", nickname: "뇸뇸", date: "21.7.18", photos: ["moon.fill", "star.fill"]),
            ReviewModel(title: "에코티끄 섬유유연제", content: "흠... 이 향 뭐지? 향이 짱 좋고 산뜻합니다! 친구들한테 추천하구 다녀영~ 최고오오오오오오오", category: "섬유유연제", nickname: "감자도리", date: "21.7.18", photos: []),
            ReviewModel(title: "인블리스 세탁세제", content: "좋습니다. 벌써 3번 리필했어요!", category: "세탁세제", nickname: "냥냥이", date: "21.7.18", photos: ["star.fill", "moon.fill", "sun.max.fill"]),
            ReviewModel(title: "에코라운드 중성 주방세제", content: "최고네용~ 캬캬캬 한 번 더 리필할 듯 싶습니다. 향이 짱 좋고 세척력도 넘넘 좋아요! 추천추천합니다ㅎㅎ", category: "주방세제", nickname: "뇸뇸", date: "21.7.18", photos: ["moon.fill", "star.fill"]),
            ReviewModel(title: "에코티끄 섬유유연제", content: "흠... 이 향 뭐지? 향이 짱 좋고 산뜻합니다! 친구들한테 추천하구 다녀영~ 최고오오오오오오오", category: "섬유유연제", nickname: "감자도리", date: "21.7.18", photos: [])
        ])
    }
    
    private func scrollToSelectedCategory(indexPath: IndexPath) {
        guard let rowIndex = productList.firstIndex(of: .product(productName: categoryList[indexPath.row])) else { return }
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
            return reviewList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionType = SectionType(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch (sectionType, itemInformationType) {
        case (.storeInformation, _):
            guard let storeInformationCell = tableView.dequeueReusableCell(
                withIdentifier: StoreInformationTableViewCell.className, for: indexPath
            ) as? StoreInformationTableViewCell else { return UITableViewCell() }
            
            storeInformationCell.storeInformationDelegate = self
            storeInformationCell.setUpperData(todayOperationTime: store?.getTodayOfficeHour(),
                                              productCategories: store?.getStoreCategories())
            storeInformationCell.setBottomData(address: store?.address,
                                               phoneNumber: store?.telephone)
            storeInformationCell.setOperationTime(operationList: store?.officeHour)
            storeInformationCell.setOperationStatusLabel(with: store)
            
            return storeInformationCell
            
        case (.itemInformation, .productList):
            guard let productCell = tableView.dequeueReusableCell(
                withIdentifier: ProductTableViewCell.className, for: indexPath
            ) as? ProductTableViewCell,
                  let itemCell = tableView.dequeueReusableCell(
                    withIdentifier: ItemTableViewCell.className, for: indexPath
                  ) as? ItemTableViewCell else { return UITableViewCell() }
            
            switch self.productList[indexPath.row] {
            case let .product(productName):
                productCell.setData(productName: productName)
                return productCell
            case let .item(itemName, itemPrice):
                itemCell.setData(itemName: itemName, itemPrice: itemPrice)
                return itemCell
            }
            
        case (.itemInformation, .reviewList):
            guard let reviewCell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.className, for: indexPath) as? ReviewTableViewCell else { return UITableViewCell() }
            reviewCell.configureUI(reviewModel: reviewList[indexPath.row])
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
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "WriteReviewNavigationController") as? UINavigationController else { return }
        present(viewController, animated: true, completion: nil)
    }
    
    func updateListCountOfButton(_ storeDetailSelectView: StoreDetailSelectView) {
        storeDetailSelectView.numberOfReviews = reviewList.count
        storeDetailSelectView.numberOfProducts = productList.count - categoryList.count
    }
}
