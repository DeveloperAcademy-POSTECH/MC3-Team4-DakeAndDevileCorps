//
//  StoreInformationTableViewCell.swift
//  DakeAndDevileCorps
//
//  Created by 최동권 on 2022/07/19.
//

import UIKit

class StoreInformationTableViewCell: UITableViewCell {
    static let identifier = "StoreInformationTableViewCell"
    
    @IBOutlet weak var operationStatus: UILabel!
    @IBOutlet weak var todayOperationTime: UILabel!
    @IBOutlet weak var productCategories: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var operationTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func setUpperData(isOperation: Bool) {
        operationStatus.text = isOperation ? "영업중" : "영업 종료"
        operationStatus.textColor = isOperation ? .systemGreen : .systemRed
        todayOperationTime.text = "10:00 ~ 18:00"
        productCategories.text = "샴푸류, 청소용품, 화장품, 식품"
        productCategories.textColor = .secondaryLabel
    }
    
    func setBottomData(address: String, phoneNumber: String, operationTime: String) {
        self.address.text = address
        self.phoneNumber.text = phoneNumber
        self.operationTime.text = operationTime
    }
}
