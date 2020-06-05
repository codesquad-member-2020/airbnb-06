//
//  MapViewController.swift
//  Airbnb
//
//  Created by jinie on 2020/06/05.
//  Copyright © 2020 jinie. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func configureMapView() {
        mapView.delegate = self
    }
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? AccommodationAnnotation else { return nil }
        
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: NSStringFromClass(AccommodationAnnotation.self), for: annotation)
        return annotationView
    }
}
