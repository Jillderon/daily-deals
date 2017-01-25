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
import FirebaseAuth

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    // MARK: Variables
    var locationManager = CLLocationManager()

    var ref = FIRDatabase.database().reference()
    var activities = [Activity]()
    var displayedActivities = [Activity]()
    var receivedCategory = String()
    
    // MARK: Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addDealButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(MapViewController.reloadPins), name: Notification.Name(rawValue: "pinsFiltered"), object: nil)
        
        showButtons()
        readDatabase()
        checkLocationAuthorizationStatus()
    }
    
    // MARK: Actions
    @IBAction func signOutDidTouch(_ sender: Any) {
        signOut()
        self.performSegue(withIdentifier: "toLoginAgain", sender: self)
    }
    
    // MARK: Functions
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedAlways {
            mapView.showsUserLocation = false
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFilterDeals" {
            let destination = segue.destination as? SearchDealViewController
            destination?.activities = self.activities
        }
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
    
    func showButtons() {
        // Retrieve data from Firebase.
        ref.child("Users").observe(.value, with: { snapshot in
            for item in snapshot.children {
                let userData = User(snapshot: item as! FIRDataSnapshot)
                if userData.uid == (FIRAuth.auth()?.currentUser?.uid)! {
                    if userData.type! == 1 {
                        self.addDealButton.isHidden = false
                    } else {
                        self.addDealButton.isHidden = true
                    }
                }
            }
        })
    }
    
    func readDatabase() {
        ref.child("activities").queryOrderedByKey().observe(.childAdded, with: { (snapshot) in
            guard let snapshotDict = snapshot.value as? [String: AnyObject] else {
                return
            }
            
            let nameDeal = snapshotDict["nameDeal"]
            let nameCompany = snapshotDict["nameCompany"]
            let address = snapshotDict["address"]
            let category = snapshotDict["category"]
            let date = snapshotDict["date"]
            let currentDate = Date().timeIntervalSince1970
            
            if date as! Double >= currentDate {
                self.activities.append(Activity(nameDeal: nameDeal! as! String, nameCompany: nameCompany! as! String, address: address! as! String, category: category! as! String, date: date as! Double))
                self.displayedActivities.append(Activity(nameDeal: nameDeal! as! String, nameCompany: nameCompany! as! String, address: address! as! String, category: category! as! String, date: date as! Double))
                self.addAllPins()
            } else {
                // delete activity in Firebase
                self.ref.child("activities").child(nameDeal as! String).removeValue { (error, ref) in
                    if error != nil {
                        print("error \(error)")
                    }
                }
            }
        })
    }
    
    func addAllPins() {
        for activity in displayedActivities {
            addPin(activity: activity)
        }
    }
    
    func addPin(activity: Activity) {
        // Create address string
        let location = "Netherlands, Amsterdam," + activity.address
        var coordinate = CLLocationCoordinate2D()
        
        
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
                    self.placeAnnotation(activity: activity, coordinate: coordinate)
                }
            }
        }
        
    }
    
    func placeAnnotation(activity: Activity, coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = activity.nameDeal
        annotation.subtitle = activity.nameCompany
        self.mapView.addAnnotation(annotation)
    }
 
    func determineMyCurrentLocation() {
        self.mapView.delegate = self
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        DispatchQueue.main.async {
            self.locationManager.startUpdatingLocation()
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
    
    func signOut() {
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
            dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    func reloadPins(notification: NSNotification) {
        mapView.removeAnnotations(mapView.annotations)

        displayedActivities = notification.object as! [Activity]
        addAllPins()
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        let annotationIdentifier = "AnnotationIdentifier"
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        } else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        if let annotationView = annotationView {
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "Other")
            annotationView.bounds.size.height /= 5
            annotationView.bounds.size.width /= 5
        }
        
        return annotationView
    }

}
