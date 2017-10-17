//
//  SingleCarViewController.swift
//  MTribes
//
//  Created by Deepesh Gairola on 17/10/17.
//  Copyright © 2017 Deepesh Gairola. All rights reserved.
//

import UIKit
import MapKit

class SingleCarViewController: UIViewController, MKMapViewDelegate{
    
    var objectCar : Car!
    var annotations: MKAnnotation!
    var locations = [MKAnnotation]()
    
    @IBOutlet var mapView: MKMapView!
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.configureMap()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeViewController(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    func configureMap() {
        
        let latitude = objectCar!.coordinates![1] as! Double
        let longitude = objectCar!.coordinates![0] as! Double
        
        self.annotations = MapPoints.init(title: objectCar.name!, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        
        self.locations.append(self.annotations)
        
        self.mapView.showAnnotations(locations, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "MyPin"
        
        
        let detailButton = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        detailButton.setImage(UIImage(named: "close.png"), for: UIControlState.normal)
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        annotationView?.canShowCallout = true
        annotationView?.image = UIImage(named: "car.png")
        annotationView?.rightCalloutAccessoryView = detailButton
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        // Do nothing for now 
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        mapView.deselectAnnotation(view.annotation, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
