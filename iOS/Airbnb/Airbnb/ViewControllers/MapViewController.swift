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
    
    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMapView()
        registerMapAnnotationView()
        displayAnnotations()
    }
    
    private func configureMapView() {
        mapView.delegate = self
    }
    
    private func registerMapAnnotationView() {
        mapView.register(AccommodationAnnotationView.self, forAnnotationViewWithReuseIdentifier: NSStringFromClass(AccommodationAnnotation.self))
    }
    
    private func displayAnnotations() {
        let request = AccommodationRequests<AccommodationListRequest>.list.request.asURLRequest()
        AccommodationUseCase(request: request, networkDispatcher: AF).perform(dataType: [Accommodation].self) { accommodationList in
            let accommodations = accommodationList as! [Accommodation]
            let annotations = accommodations.map { AccommodationAnnotation(coordinate: CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude), price: $0.price) }
            self.mapView.addAnnotations(annotations)
            self.centerMapOnSanFrancisco()
            self.mapView.setNeedsLayout()
        }
    }
    
    private func centerMapOnSanFrancisco() {
        let center = CLLocationCoordinate2D(latitude: 37.76931, longitude: -122.43386)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        mapView.setRegion(MKCoordinateRegion(center: center, span: span), animated: true)
    }
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? AccommodationAnnotation else { return nil }
        
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: NSStringFromClass(AccommodationAnnotation.self), for: annotation)
        return annotationView
    }
}
