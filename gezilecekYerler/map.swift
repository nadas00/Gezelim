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

class map: UIViewController, MKMapViewDelegate {



    @IBOutlet weak var mapView: MKMapView!
    
    var myInitLocation = CLLocationCoordinate2D(latitude: 38.376324, longitude: 27.142932)

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate=self
     
        let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        let region = MKCoordinateRegion(center: myInitLocation, span: span)
        createPolyline()
        mapView.setRegion(region, animated: true)

        var locations = [CLLocationCoordinate2DMake]
           var loc2 = [CLLocationCoordinate2DMake]
          locations.append(contentsOf:loc2)
        

    }
    
  
    
    func createPolyline(){
        let locations = [
            CLLocationCoordinate2DMake(38.337683, 27.128267), //GAZİEMİR
            CLLocationCoordinate2DMake(38.153832, 27.387889), //TORBALI
              CLLocationCoordinate2DMake(38.472526, 27.221037) //BORNOVA
          
              
        ]

        
        //create a Polyline
        let aPolyline = MKPolyline(coordinates: locations, count: locations.count)

        mapView.addOverlay(aPolyline)
        
        
        //create pins
        
         let sourceLocation = CLLocationCoordinate2D(latitude:locations[0].latitude , longitude: locations[0].longitude)
         let sourcePin = customPin(pinTitle: "Gaziemir", pinSubTitle: "", location: sourceLocation)
         self.mapView.addAnnotation(sourcePin)
             
             
         let destinationLocation = CLLocationCoordinate2D(latitude:locations[1].latitude , longitude: locations[1].longitude)
         let destinationPin = customPin(pinTitle: "Torbalı", pinSubTitle: "", location: destinationLocation)
         self.mapView.addAnnotation(destinationPin)
             
         let son = CLLocationCoordinate2D(latitude:locations[2].latitude , longitude: locations[2].longitude)
         let sonPin = customPin(pinTitle: "Bornova", pinSubTitle: "", location: son)
         self.mapView.addAnnotation(sonPin)
             
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
