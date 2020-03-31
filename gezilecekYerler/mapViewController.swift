//
//  ViewController.swift
//  DrawRouteOnMapKit
//
//  Created by Aman Aggarwal on 08/03/18.
//  Copyright © 2018 Aman Aggarwal. All rights reserved.
//

import UIKit
import MapKit

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

class mapViewController: UIViewController, MKMapViewDelegate {

    var locations = [String]()
    var coords = [String]()
    var longs = [Double]()
    var lats = [Double]()
    

    @IBOutlet weak var mapView: MKMapView!
    
    var myInitLocation = CLLocationCoordinate2D(latitude: 38.376324, longitude: 27.142932)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(locations)
        print(longs)
        print(lats)
        
        
       
        
        
        mapView.delegate=self
     
        let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        let region = MKCoordinateRegion(center: myInitLocation, span: span)
        createPolyline()
        mapView.setRegion(region, animated: true)

        
    }
    
  
    
    
    
    func createPolyline(){
        

        
   
        
        let arr = zip(lats, longs).map({[$0.0, $0.1]})
        
        
    let locations = arr.map { CLLocationCoordinate2D(latitude: $0[0], longitude: $0[1]) }


        
        //create a Polyline
        let aPolyline = MKPolyline(coordinates: locations, count: locations.count)

        mapView.addOverlay(aPolyline)
        
    
        
//
//self.mapView.addAnnotation(customPin(pinTitle: "Gaziemir", pinSubTitle: "", location: CLLocationCoordinate2D(latitude: locations[0].latitude, longitude: locations[0].longitude) ))
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


}

//
