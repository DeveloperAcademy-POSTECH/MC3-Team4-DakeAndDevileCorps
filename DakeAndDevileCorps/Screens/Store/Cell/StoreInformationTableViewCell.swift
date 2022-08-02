//
//  StoreInformationTableViewCell.swift
//  DakeAndDevileCorps
//
//  Created by 최동권 on 2022/07/19.
//

import UIKit

protocol StoreDetailTableViewCellDelegate: AnyObject {
    func reloadStoreDetailTableView()
}

class StoreInformationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var operationStatusLabel: UILabel!
    @IBOutlet weak var todayOperationTimeLabel: UILabel!
    @IBOutlet weak var betweenDot: UILabel!
    @IBOutlet weak var productCategoriesLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var operationTimeLabel: UILabel!
    
    @IBOutlet weak var mondayLabel: UILabel!
    @IBOutlet weak var tuesdayLabel: UILabel!
    @IBOutlet weak var wednesdayLabel: UILabel!
    @IBOutlet weak var thursdayLabel: UILabel!
    @IBOutlet weak var fridayLabel: UILabel!
    @IBOutlet weak var saturdayLabel: UILabel!
    @IBOutlet weak var sundayLabel: UILabel!
    
    @IBOutlet weak var weekOperationTimeStack: UIStackView!
    @IBOutlet weak var weekOperationTimeToggle: UIButton!
    
    weak var storeInformationDelegate: StoreDetailTableViewCellDelegate?
    private var isOpen: Bool = true
    private var dateLabels: [UILabel] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setDateLabel()
    }
    
    @IBAction func toggleWeekOperationTime(_ sender: Any) {
        isOpen.toggle()
        weekOperationTimeToggle.setBackgroundImage(UIImage(systemName: isOpen ? "chevron.down" : "chevron.up"), for: .normal)
        for dateLabel in dateLabels {
            dateLabel.isHidden.toggle()
        }
        storeInformationDelegate?.reloadStoreDetailTableView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setDateLabel() {
        dateLabels.append(contentsOf: [
            mondayLabel,
            tuesdayLabel,
            wednesdayLabel,
            thursdayLabel,
            fridayLabel,
            saturdayLabel,
            sundayLabel
        ])
    }
    
    func setUpperData(todayOperationTime: String?,
                      productCategories: String?) {
        if let todayOperationTime = todayOperationTime,
           let productCategories = productCategories {
            todayOperationTimeLabel.text = todayOperationTime
            productCategoriesLabel.text = productCategories
        }
        self.productCategoriesLabel.textColor = .secondaryLabel
    }
    
    func setBottomData(address: String?,
                       phoneNumber: String?) {
        if let address = address,
           let phoneNumber = phoneNumber {
            addressLabel.text = address
            phoneNumberLabel.text = phoneNumber
        }
    }
    
    func setOperationTime(operationList: [String]?) {
        for (index, dateLabel) in dateLabels.enumerated() {
            dateLabel.text = operationList?[index]
            dateLabel.textColor = .secondaryLabel
        }
    }
    
    func setOperationStatusLabel(with store: Store?) {
        guard let store = store else { return }
        operationStatusLabel.text = store.getOfficeHourState().title
        operationStatusLabel.textColor = store.getOfficeHourState().titleColor
        operationStatusLabel.font = .preferredFont(forTextStyle: .callout, compatibleWith: .init(legibilityWeight: .bold))
        operationTimeLabel.text = store.getTodayOfficeHour()
    }
    
    func setBetweenDot() {
        betweenDot.isHidden = true
    }
}
