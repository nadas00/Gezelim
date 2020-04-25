//
//  ViewController.swift
//  DrawRouteOnMapKit
//
//  Created by Aman Aggarwal on 08/03/18.
//  Copyright © 2018 Aman Aggarwal. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class customPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(pinTitle:String, pinSubTitle:String, location:CLLocationCoordinate2D) {
        self.title = pinTitle
        self.subtitle = pinSubTitle
        self.coordinate = location
    }
}

class mapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    var locationNames = [String]()
    var coords = [String]()
    var longs = [Double]()
    var lats = [Double]()
    
     let locationManager = CLLocationManager()
    

    @IBOutlet weak var mapView: MKMapView!
    
    
//viewdidappear animasyon için
    override func viewDidAppear(_ animated: Bool) {
    super.viewDidLoad()
        
            checkLocationServices()
       
        
        
      
        print(locationNames)
        print(longs)
        print(lats)
        
        
       
        
        
        mapView.delegate=self
        
        var myInitLocation = CLLocationCoordinate2D(latitude: lats[0], longitude: longs[0])
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
             let region = MKCoordinateRegion(center: myInitLocation, span: span)
           
             mapView.setRegion(region, animated: true)
        
          createPolyline()
  
        
    }
    
  
    
    
    
    func createPolyline(){
        

        
   
        
        let arr = zip(lats, longs).map({[$0.0, $0.1]})
        let locations = arr.map { CLLocationCoordinate2D(latitude: $0[0], longitude: $0[1]) }
        
        
        
        let annots = zip(locationNames, locations).map{customPin(pinTitle: $0, pinSubTitle: "", location: $1)}
        mapView?.addAnnotations(annots)


        
        //create a Polyline
        let aPolyline = MKPolyline(coordinates: locations, count: locations.count)

        mapView.addOverlay(aPolyline)
        
    
        

     
    
     
     
    
        
//self.mapView.addAnnotation(customPin(pinTitle: "Gaziemir", pinSubTitle: "", location: CLLocationCoordinate2D(latitude: locations[0].latitude, longitude: locations[0].longitude) ))
//
//self.mapView.addAnnotation(customPin(pinTitle: "Torbalı", pinSubTitle: "", location: CLLocationCoordinate2D(latitude: locations[1].latitude, longitude: locations[1].longitude) ))

        
             
    }



    //MARK:- MapKit delegates

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
let polylineRender = MKPolylineRenderer(overlay: overlay)
        polylineRender.strokeColor = UIColor.red.withAlphaComponent(0.5)
        polylineRender.lineWidth = 5
        return polylineRender

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


     func setupLocationManager() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        }
        
        

        
        
        func checkLocationServices() {
            if CLLocationManager.locationServicesEnabled() {
                setupLocationManager()
                checkLocationAuthorization()
              
                      
            } else {
                // Show alert letting the user know they have to turn this on.
            }
        }
        
        
        func checkLocationAuthorization() {
            switch CLLocationManager.authorizationStatus() {
            case .authorizedWhenInUse:
                mapView.showsUserLocation = true
                let konumLat = locationManager.location?.coordinate.latitude
                                                           let konumLong =  locationManager.location?.coordinate.longitude
                                                        
                                                        

                                        lats.insert(konumLat!, at: 0)
                                                                         longs.insert(konumLong!, at: 0)
                                                                         locationNames.insert("konumum", at: 0)
                                    
                
              
                                    
                                 
                
                locationManager.startUpdatingLocation()
                break
            case .denied:
                // Show alert instructing them how to turn on permissions
                break
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                // Show an alert letting them know what's up
                break
            case .authorizedAlways:
                break
            }
        }
    }







//
