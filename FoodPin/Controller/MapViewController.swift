//
//  MapViewController.swift
//  FoodPin
//
//  Created by chiaqingwu on 2020/8/8.
//  Copyright © 2020 AppCoda. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    
    var restaurant = Restaurant()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMap()
    }
    
    //MARK: - Private methods
    private func loadMap() {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(restaurant.location, completionHandler: { (placeMarks, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let placeMarks = placeMarks, let location = placeMarks[0].location else { return }
            let annotation = MKPointAnnotation()
            
            annotation.title = self.restaurant.name
            annotation.subtitle = self.restaurant.type
            annotation.coordinate = location.coordinate
            
            self.mapView.showAnnotations([annotation], animated: true)
            self.mapView.selectAnnotation(annotation, animated: true)
        })
    }
    
}
