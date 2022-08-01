//
//  ResultTableViewCell.swift
//  DakeAndDevileCorps
//
//  Created by Seungyun Kim on 2022/07/19.
//

import CoreLocation
import UIKit

class ResultTableViewCell: UITableViewCell {

    static let identifier = "ResultTableViewCell"
    
    @IBOutlet weak var storeTitle: UILabel!
    @IBOutlet weak var storeAddress: UILabel!
    @IBOutlet weak var distanceToStore: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(title: String, address: String, latitude: Double, longitude: Double) {
        storeTitle.text = title
        storeAddress.text = address
        
        guard let currentLatitude = Double(UserDefaultStorage.currentLatitude),
              let currentLongitude = Double(UserDefaultStorage.currentLongitude)
        else { return }
        let currentCoordinator = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let coordinator = CLLocationCoordinate2D(latitude: currentLatitude, longitude: currentLongitude)
        let distance = currentCoordinator.distance(from: coordinator) / 1000
        distanceToStore.text = String(format: "%.01fkm", distance)
    }

}
