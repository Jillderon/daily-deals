//
//  MapViewController.swift
//  DailyDeals
//
//  Description:
//  This is the main screen of the app, where all the deals are displayed as pin annotations on the map. 
//  Pin Annotations can be clicked so information about the selected deal is displayed.
//  Their are four buttons redirecting the user to other ViewControllers.
//
//  Created by practicum on 12/01/17.
//  Copyright © 2017 Jill de Ron. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase
import FirebaseAuth
import FirebaseDatabase

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    // MARK: Variables.
    var locationManager = CLLocationManager()
    var ref = FIRDatabase.database().reference()
    var deals = [Deal]()
    var displayedDeals = [Deal]()
    var receivedCategory = String()
    var annotationTitle = String()
    var annotationSubtitle = String()
    
    // MARK: Outlets.
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addDealButton: UIButton!
    @IBOutlet weak var myDealsButton: UIButton!
    
    // MARK: Actions.
    @IBAction func signOutDidTouch(_ sender: Any) {
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
            dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        self.performSegue(withIdentifier: "toLoginAgain", sender: self)
    }
    
    // MARK: Standard functions.
    override func viewDidLoad() {
        super.viewDidLoad()
        determineMyCurrentLocation()
        
        NotificationCenter.default.addObserver(self, selector: #selector(MapViewController.reloadAnnotations), name: Notification.Name(rawValue: "annotationsFiltered"), object: nil)
        
        typeOfUserVerification()
        checkLocationAuthorizationStatus()
        readDatabase()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(MapViewController.readDatabaseAgain), name: Notification.Name(rawValue: "deletedDeals"), object: nil)
        
        // Hide the navigation bar on the this view controller.
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers.
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: Function to check user account.
    private func typeOfUserVerification() {
        // Check type of user account.
        ref.child("Users").observe(.value, with: { snapshot in
            for item in snapshot.children {
                let userData = User(snapshot: item as! FIRDataSnapshot)
                if userData.uid == (FIRAuth.auth()?.currentUser?.uid)! {
                    if userData.type! == 1 {
                        self.addDealButton.isHidden = false
                        self.myDealsButton.isHidden = false
                    } else {
                        self.addDealButton.isHidden = true
                        self.myDealsButton.isHidden = true
                    }
                }
            }
        })
    }
    
    // MARK: Load deals data from firebase and place on map.
    private func readDatabase() {
        ref.child("deals").queryOrderedByKey().observe(.childAdded, with: { (snapshot) in
            guard let snapshotDict = snapshot.value as? [String: AnyObject] else {
                return
            }
            
            let nameDeal = snapshotDict["nameDeal"]
            let nameCompany = snapshotDict["nameCompany"]
            let category = snapshotDict["category"]
            let longitude = snapshotDict["longitude"]
            let latitude = snapshotDict["latitude"]
            let date = snapshotDict["date"]
            let uid = snapshotDict["uid"]
            let currentDate = Date().timeIntervalSince1970
            
            if date as! Double >= currentDate {
                self.deals.append(Deal(nameDeal: nameDeal! as! String, nameCompany: nameCompany! as! String, longitude: longitude! as! Double, latitude: latitude! as! Double, category: category! as! String, date: date as! Double, uid: uid as! String))
                self.displayedDeals.append(Deal(nameDeal: nameDeal! as! String, nameCompany: nameCompany! as! String, longitude: longitude! as! Double, latitude: latitude! as! Double, category: category! as! String, date: date as! Double, uid: uid as! String))
                self.addAllAnnotations()
            } else {
                // delete deal in Firebase
                self.ref.child("deals").child(nameDeal as! String).removeValue { (error, ref) in
                    if error != nil {
                        print("error \(error)")
                    }
                }
            }
        })
    }
    
    func readDatabaseAgain(notification: NSNotification) {
        mapView.removeAnnotations(mapView.annotations)
        readDatabase()
    }
    
    func reloadAnnotations(notification: NSNotification) {
        mapView.removeAnnotations(mapView.annotations)
        
        displayedDeals = notification.object as! [Deal]
        addAllAnnotations()
    }
    
    private func addAllAnnotations() {
        for deal in displayedDeals {
            addAnnotation(deal: deal)
        }
    }
    
   private func addAnnotation(deal: Deal) {
        let coordinate = CLLocationCoordinate2DMake(deal.latitude, deal.longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = deal.nameDeal
        annotation.subtitle = deal.nameCompany
        self.mapView.addAnnotation(annotation)

    }
    
    // MARK: Location Manager.
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
    
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedAlways {
            mapView.showsUserLocation = false
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    private func determineMyCurrentLocation() {
        self.mapView.delegate = self
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        DispatchQueue.main.async {
            self.locationManager.startUpdatingLocation()
        }
    }
    
    // MARK: MapView.
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
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            performSegue(withIdentifier: "toDealInformation", sender: nil)
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation as? MKPointAnnotation {
            annotationTitle = annotation.title!
            annotationSubtitle = annotation.subtitle!
        }
    }
    
    // MARK: Segues.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFilterDeals" {
            let destination = segue.destination as? FilterDealViewController
            
            // Define variabeles you want to sent to next ViewController.
            destination?.deals = self.deals
        }
        
        if segue.identifier == "toDealInformation" {
            let destination = segue.destination as? InformationDealViewController
            
            // Define variables you want to sent to next ViewController.
            destination?.nameDealReceiver = self.annotationTitle
            destination?.nameCompanyReceiver = self.annotationSubtitle
        }
    }

}
