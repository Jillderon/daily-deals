//
//  MapViewController.swift
//  DailyDeals
//
//
//  Created by practicum on 12/01/17.
//  Copyright © 2017 Jill de Ron. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import FirebaseDatabase

class MapViewController: UIViewController, CLLocationManagerDelegate {

    // MARK: Variables
    var locationManager: CLLocationManager!
    var ref: FIRDatabaseReference?
    var activities = [Activity]()
    
    // MARK: Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readDatabase()
        addPins()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func readDatabase() {
        ref = FIRDatabase.database().reference()
        ref?.child("activities").queryOrderedByKey().observe(.childAdded, with: { (snapshot) in
            guard let snapshotDict = snapshot.value as? [String: String] else {
                return
            }
            
            let nameDeal = snapshotDict["nameDeal"]
            let nameCompany = snapshotDict["nameCompany"]
            let address = snapshotDict["address"]
            self.activities.append(Activity(nameDeal: nameDeal!, nameCompany: nameCompany!, address: address!))
        })
    }
    
    func addPins() {
        print("hij komt wel in de functie..")
        print("ACTIVITIES")
        print(self.activities)
        for activity in activities {
            addPin(activity: activity)
            print("..maar hij komt niet in de loop")
        }
    }
    
    func addPin(activity: Activity) {
        for activity in activities {
            // Create address string
            let location = "Netherlands, Amsterdam," + activity.address
            var coordinate = CLLocationCoordinate2D()
            print("COORDINATE2")
            print(coordinate)
            
            // Geocode Address String
            let geoCoder = CLGeocoder()
            geoCoder.geocodeAddressString(location) { (placemarks, error) in
                if let error = error {
                    print("Unable to Forward Geocode Address (\(error))")
                } else {
                    var locationPin: CLLocation?
                    if let placemarks = placemarks, placemarks.count > 0 {
                        locationPin = placemarks.first?.location
                    }
                    
                    if let locationPin = locationPin {
                        coordinate = locationPin.coordinate
                        print("COORDINATE:")
                        print(coordinate)
                    }
                    
                }
                
                
                // Place annotation
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = activity.nameDeal
                annotation.subtitle = activity.nameCompany
                self.mapView.addAnnotation(annotation)
            }

        }
    }
 
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
        
    }

    func locationManager(_  manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        mapView.setRegion(region, animated: true)
        manager.stopUpdatingLocation()
        self.mapView.showsUserLocation = true
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        determineMyCurrentLocation()
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}
