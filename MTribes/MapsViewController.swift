//
//  MapsViewController.swift
//  MTribes
//
//  Created by Deepesh Gairola on 16/10/17.
//  Copyright © 2017 Deepesh Gairola. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import MapKit

class MapsViewController: UIViewController, NVActivityIndicatorViewable, MKMapViewDelegate {

    var searchResult: [Car]!
    var annotations: MKAnnotation!
    var locations = [MKAnnotation]()
    
    
    @IBOutlet var mapView: MKMapView!
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.title = "Maps"
        
        startAnimating(NVActivityIndicatorView.DEFAULT_BLOCKER_SIZE, message: "Please wait while we search a suitable ride for you!", messageFont: UIFont.systemFont(ofSize: 24), type: .orbit, color: UIColor.white, padding: nil, displayTimeThreshold: 2, minimumDisplayTime: 2, backgroundColor: UIColor(red: 0.9020, green: 0.3490, blue: 0.4000, alpha: 1), textColor: UIColor.white)
        
        self.getCarData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getCarData() {
        
        let requestHandler = CarDataRequestHandler()
        
        requestHandler.requestCabDataFromServer(completion: { (result, error, statusCode) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { // in half a second...
                self.stopAnimating()
                self.searchResult = result.car
                self.configureMap()
            }
        })
    }
    
    func configureMap() {

        for objCar in self.searchResult {
            
            let latitude = objCar.coordinates![1] as! Double
            let longitude = objCar.coordinates![0] as! Double
            
            self.annotations = MapPoints.init(title: objCar.name!, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))

            self.locations.append(self.annotations)

        }
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
        for annotation in mapView.annotations {
            let pin = mapView.view(for: annotation)
            
            if (pin?.annotation?.coordinate.latitude != view.annotation?.coordinate.latitude){
                pin?.isHidden = true
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        mapView.deselectAnnotation(view.annotation, animated: true)
        
        for annotation in mapView.annotations {
            mapView.view(for: annotation)?.isHidden = false
        }
        
    }
}
