//
//  ViewController.swift
//  Capital Cities
//
//  Created by Felix Leitenberger on 18.06.20.
//  Copyright © 2020 Felix Leitenberger. All rights reserved.
//

import UIKit
import MapKit
import WebKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
        
        mapView.addAnnotations([london, oslo, paris, rome, washington])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(changeMapType))
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "Capital") as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Capital")
            annotationView?.canShowCallout = true
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            annotationView?.annotation = annotation
        }
        
        annotationView?.pinTintColor = .green
        
        return annotationView
    }

    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        let placeName = capital.title
        let placeInfo = capital.info
        
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        ac.addAction(UIAlertAction(title: "Show Wiki", style: .default, handler: { _ in
            let webVC = UIViewController()
            let webView = WKWebView(frame: webVC.view.bounds)
            if let url = URL(string: "https://en.wikipedia.org/wiki/\(placeName ?? "Neverland")") {
                let request = URLRequest(url: url)
                webView.load(request)
            }
            webVC.view.addSubview(webView)
            self.navigationController?.pushViewController(webVC, animated: true)
        }))
        present(ac, animated: true)
    }
    
    
    @objc func changeMapType() {
        let ac = UIAlertController(title: "Change Map Type", message: nil, preferredStyle: .actionSheet)
        
        let mapTypes: [String: MKMapType] = ["Standard": .standard,"Satellit": .satellite, "Hybrid": .hybrid, "HybridFlyOver": .hybridFlyover, "MutedStandard": .mutedStandard, "SatelliteFlyover": .satelliteFlyover]
        
        for type in mapTypes {
            ac.addAction(UIAlertAction(title: "\(type.key)", style: .default, handler: { _ in
                self.mapView.mapType = type.value
            }))
        }
        
        present(ac, animated: true)
    }
}

