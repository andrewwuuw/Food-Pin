//
//  MapViewController.swift
//  FoodPin
//
//  Created by chiaqingwu on 2020/8/8.
//  Copyright © 2020 AppCoda. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!

    var restaurant = Restaurant()

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        self.loadMap()
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.showsTraffic = true
    }

    //MARK: - map view delegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "myMarker"

        // 如果餐廳座標跟使用者現在的座標位置相同
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }

        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }

        annotationView?.glyphText = "🤣"
        annotationView?.markerTintColor = .orange

        return annotationView
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
