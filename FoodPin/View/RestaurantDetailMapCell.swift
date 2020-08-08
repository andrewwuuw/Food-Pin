//
//  RestaurantDetailMapCell.swift
//  FoodPin
//
//  Created by chiaqingwu on 2020/8/7.
//  Copyright © 2020 AppCoda. All rights reserved.
//

import UIKit
import MapKit

class RestaurantDetailMapCell: UITableViewCell {

    @IBOutlet var mapView: MKMapView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(location: String) {
        // 取得位置
        let geoCoder = CLGeocoder()
        print("* \(location)")

        geoCoder.geocodeAddressString(location, completionHandler: { (placeMarks, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            // 加上標記
            let annotation = MKPointAnnotation()
            guard let placeMarks = placeMarks, let location = placeMarks[0].location else { return }

            // 顯示標記
            annotation.coordinate = location.coordinate
            self.mapView.addAnnotation(annotation)

            // 縮放程度
            let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 250, longitudinalMeters: 250)
            self.mapView.setRegion(region, animated: false)

        })
    }

}
