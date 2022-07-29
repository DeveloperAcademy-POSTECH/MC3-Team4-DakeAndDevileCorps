//
//  StoreViewController.swift
//  DakeAndDevileCorps
//
//  Created by Seungyun Kim on 2022/07/18.
//

import UIKit

class StoreDetailViewController: UIViewController {
    
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var storeDetailTableView: UITableView!
    
    private var productList: [ProductTableViewCellModel] = []
    private var operationList: [String] = []
    private let categoryList: [String] = ["주방세제", "세탁세제", "섬유유연제", "기타세제", "헤어", "스킨", "바디", "식품", "생활", "문구", "애견", "기타"]
    private var reviewList: [ReviewModel] = []
    private var isShowingReview: Bool = true
    private var selectHeader = StoreDetailSelectView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configStoreDetailTableView()
        initStoreInformationData()
        configSelectHeader()
    }
    
    func configStoreDetailTableView() {
        storeDetailTableView.dataSource = self
        storeDetailTableView.delegate = self
        storeDetailTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        storeName.text = "알맹상점"
        storeName.font = UIFont.boldSystemFont(ofSize: 22)
        if #available(iOS 15.0, *) {
            storeDetailTableView.sectionHeaderTopPadding = 0
        }
    }
    
    func configSelectHeader() {
        selectHeader.delegate = self
        selectHeader.backgroundColor = .white
    }
    
    func initStoreInformationData() {
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
        
        operationList = ["월 정기 휴일", "화 10:00 ~ 18:00", "수 10:00 ~ 18:00", "목 10:00 ~ 18:00", "금 10:00 ~ 18:00", "토 10:00 ~ 18:00", "일 정기 휴일"]
        
        reviewList.append(contentsOf: [
            ReviewModel(reviewTitle: "인블리스 세탁세제", reviewContent: "좋습니다. 벌써 3번 리필했어요!", category: "세탁세제", nickname: "냥냥이", reviewDate: "21.7.18", reviewImageNames: ["star.fill", "moon.fill", "sun.max.fill"]),
            ReviewModel(reviewTitle: "에코라운드 중성 주방세제", reviewContent: "최고네용~ 캬캬캬 한 번 더 리필할 듯 싶습니다. 향이 짱 좋고 세척력도 넘넘 좋아요! 추천추천합니다ㅎㅎ", category: "주방세제", nickname: "뇸뇸", reviewDate: "21.7.18", reviewImageNames: ["moon.fill", "star.fill"]),
            ReviewModel(reviewTitle: "에코티끄 섬유유연제", reviewContent: "흠... 이 향 뭐지? 향이 짱 좋고 산뜻합니다! 친구들한테 추천하구 다녀영~ 최고오오오오오오오", category: "섬유유연제", nickname: "감자도리", reviewDate: "21.7.18", reviewImageNames: nil)
        ])
    }
    
    func scrollToSelectedCategory(indexPath: IndexPath) {
        guard let rowIndex = productList.firstIndex(of: .product(productName: categoryList[indexPath.row])) else { return }
        let indexPath = IndexPath(row: rowIndex, section: 1)
        storeDetailTableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}

extension StoreDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            if !isShowingReview {
                return productList.count
            } else {
                return reviewList.count
            }
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let storeInformationCell = tableView.dequeueReusableCell(
                withIdentifier: StoreInformationTableViewCell.className, for: indexPath
            ) as? StoreInformationTableViewCell else { return UITableViewCell() }
            
            storeInformationCell.storeInformationDelegate = self
            storeInformationCell.setUpperData(isOperation: true, todayOperationTime: "10:00 ~ 18:00", productCategories: "화장품, 청소용품, 화장품, 식품")
            storeInformationCell.setBottomData(address: "서울 마포구 월드컵로25길 47 3층", phoneNumber: "010-2229-1027", operationTime: "10:00 - 18:00")
            storeInformationCell.setUpperData(isOperation: true,
                                              todayOperationTime: "10:00 ~ 18:00",
                                              productCategories: "화장품, 청소용품, 화장품, 식품")
            storeInformationCell.setBottomData(address: "서울 마포구 월드컵로25길 47 3층",
                                               phoneNumber: "010-2229-1027",
                                               operationTime: "10:00 - 18:00")
            storeInformationCell.setOperationTime(operationList: operationList)
            
            return storeInformationCell
        case 1:
            if isShowingReview {
                guard let reviewCell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.className, for: indexPath) as? ReviewTableViewCell else { return UITableViewCell() }
                reviewCell.setData(reviewModel: reviewList[indexPath.row])
                reviewCell.reviewDelegate = self
                return reviewCell
            } else {
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
            }
        default:
            return UITableViewCell()
        }
    }
}

extension StoreDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 1:
            let view = UIStackView()
            view.axis = .vertical
            view.addArrangedSubview(selectHeader)
            if !isShowingReview {
                let categoryHeader = CategoryView(entryPoint: CategoryEntryPoint.detail)
                categoryHeader.delegate = self
                categoryHeader.backgroundColor = .white
                view.addArrangedSubview(categoryHeader)

                NSLayoutConstraint.activate([
                    selectHeader.heightAnchor.constraint(equalToConstant: 60),
                    categoryHeader.heightAnchor.constraint(equalToConstant: 60)
                ])
            }
            return view
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 1:
            if isShowingReview {
               return 60
            } else {
                return 120
            }
        default:
            return 0
        }
    }
}

extension StoreDetailViewController: StoreInformationTableViewCellDelegate {
    func requestReload() {
//        storeDetailTableView.reloadSections(IndexSet(0...0), with: .none)
//        storeDetailTableView.reloadRows(at: [IndexPath(item: 0, section: 0)], with: .none)
        storeDetailTableView.reloadData()
    }
}

extension StoreDetailViewController: CategoryCollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        scrollToSelectedCategory(indexPath: indexPath)
    }
}

extension StoreDetailViewController: ReviewTableViewCellDelegate {
    func requestReviewTableViewCellReload() {
        storeDetailTableView.reloadData()
    }
}

extension StoreDetailViewController: StoreDetailSelectViewDelegate {
    func showingReview(cell: StoreDetailSelectView) {
        isShowingReview = true
        cell.isShowingReview = true
        cell.applyShowingState()
        storeDetailTableView.reloadData()
    }
    
    func showingProduct(cell: StoreDetailSelectView) {
        isShowingReview = false
        cell.isShowingReview = false
        cell.applyShowingState()
        storeDetailTableView.reloadData()
        
    }
}
