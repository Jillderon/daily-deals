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
//    let ref = FIRDatabase.database().reference(withPath: "activities")
    var ref: FIRDAtabaseReference?
    
    
    //    var databaseHandle: FIRDatabaseHandle
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        determineMyCurrentLocation()
    }
    
    func addPins() {
        
    }
    
    func readDatabase() {
//        ref = FIRDatabase.database().reference()
        
        ref.child("activities").queryOrderedByKey().observe(.childAdded, with: { (snapshot) in
            
            for item in snapshot.children {
                let activity = Activity(snapshot: item as! FIRDatasnapshot)
                activities.append(activity)
            }
            
//            guard let snapshotDict = snapshot.value as? [String: String] else {
//                return
//            }
//            
//            let nameDeal = snapshotDict["nameDeal"]
//            let nameCompany = snapshotDict["nameCompany"]
//            let address = snapshotDict["address"]
//            self.activities.append(Activity(nameDeal: nameDeal!, nameCompany: nameCompany!, address: address!))
        })
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
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }

}
