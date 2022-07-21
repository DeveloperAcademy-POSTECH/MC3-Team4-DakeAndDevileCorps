//
//  StoreInformationTableViewCell.swift
//  DakeAndDevileCorps
//
//  Created by 최동권 on 2022/07/19.
//

import UIKit

protocol StoreInformationTableViewCellDelegate: UITableView {
    func requestReload(cell: StoreInformationTableViewCell)
}

class StoreInformationTableViewCell: UITableViewCell {
    
    static let identifier = "StoreInformationTableViewCell"
    
    @IBOutlet weak var operationStatus: UILabel!
    @IBOutlet weak var todayOperationTime: UILabel!
    @IBOutlet weak var productCategories: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var operationTime: UILabel!
    
    @IBOutlet weak var monday: UILabel!
    @IBOutlet weak var tuesday: UILabel!
    @IBOutlet weak var wednesday: UILabel!
    @IBOutlet weak var thursday: UILabel!
    @IBOutlet weak var friday: UILabel!
    @IBOutlet weak var saturday: UILabel!
    @IBOutlet weak var sunday: UILabel!
    
    @IBOutlet weak var weekOperationTime: UIStackView!
    @IBOutlet weak var weekOperationTimeToggle: UIButton!
    
    weak var storeInformationDelegate: StoreInformationTableViewCellDelegate?
    var isOpen: Bool = true
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func toggleWeekOperationTime(_ sender: Any) {
        isOpen.toggle()
        weekOperationTimeToggle.setBackgroundImage(UIImage(systemName: isOpen ? "chevron.down" : "chevron.up"), for: .normal)
        weekOperationTime.isHidden.toggle()
        storeInformationDelegate?.requestReload(cell: self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func setUpperData(isOperation: Bool, todayOperationTime: String, productCategories: String) {
        operationStatus.text = isOperation ? "영업중" : "영업 종료"
        operationStatus.textColor = isOperation ? .systemGreen : .systemRed
        self.todayOperationTime.text = todayOperationTime
        self.productCategories.text = productCategories
        self.productCategories.textColor = .secondaryLabel
    }
    
    func setBottomData(address: String, phoneNumber: String, operationTime: String) {
        self.address.text = address
        self.phoneNumber.text = phoneNumber
        self.operationTime.text = operationTime
    }
    
    func setOperationTime(monday: String,
                          tuesday: String,
                          wednesday: String,
                          thursday: String,
                          friday: String,
                          saturday: String,
                          sunday: String) {
        self.monday.text = monday
        self.tuesday.text = tuesday
        self.wednesday.text = wednesday
        self.thursday.text = thursday
        self.friday.text = friday
        self.saturday.text = saturday
        self.sunday.text = sunday
        
    }
    
}
