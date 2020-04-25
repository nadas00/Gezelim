////
////  MapScreen.swift
////  User-Location
////
////  Created by Sean Allen on 8/24/18.
////  Copyright © 2018 Sean Allen. All rights reserved.
////
//
//import UIKit
//import MapKit
//import CoreLocation
//
//class MapScreen: UIViewController {
//
//    @IBOutlet weak var mapView: MKMapView!
//
//    let locationManager = CLLocationManager()
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//        print(locationManager.location?.coordinate.latitude)
//        print(locationManager.location?.coordinate.longitude)
//        checkLocationServices()
//    }
//
//
//    func setupLocationManager() {
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//    }
//
//
//
//
//
//    func checkLocationServices() {
//        if CLLocationManager.locationServicesEnabled() {
//            setupLocationManager()
//            checkLocationAuthorization()
//        } else {
//            // Show alert letting the user know they have to turn this on.
//        }
//    }
//
//
//    func checkLocationAuthorization() {
//        switch CLLocationManager.authorizationStatus() {
//        case .authorizedWhenInUse:
//            mapView.showsUserLocation = true
//
//            locationManager.startUpdatingLocation()
//            break
//        case .denied:
//            // Show alert instructing them how to turn on permissions
//            break
//        case .notDetermined:
//            locationManager.requestWhenInUseAuthorization()
//        case .restricted:
//            // Show an alert letting them know what's up
//            break
//        case .authorizedAlways:
//            break
//        }
//    }
//}
//
//
//extension MapScreen: CLLocationManagerDelegate {
//
//
//
//
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        checkLocationAuthorization()
//    }
//}
//
//
