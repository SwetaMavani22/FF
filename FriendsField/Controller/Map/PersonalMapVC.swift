//
//  PersonalMapVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 18/05/22.
//

import UIKit
import MapKit
import CoreLocation

protocol SelectedLocation {
    
    func DelegateSelectedLocation(lat : Double , long : Double)
}

class PersonalMapVC: UIViewController, UIGestureRecognizerDelegate {
    
    //MARK: - Variables
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager: CLLocationManager!
    let newPin = MKPointAnnotation()
    var LAT = 0.0
    var LONG = 0.0
    var ISFrom = ""
    
    var delegate : SelectedLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SetupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
    }
    
    //MARK: - Private Method
    func SetupUI() {
        
        self.SetLocation()
    }
    
    func SetLocation() {
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        mapView.delegate = self
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        self.setMapviewGuester()
    }
    
    func setMapviewGuester() {
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress(gestureReconizer:)))
        lpgr.minimumPressDuration = 0.1
        lpgr.delaysTouchesBegan = false
        lpgr.delegate = self
        self.mapView.addGestureRecognizer(lpgr)
    }
    
    @objc func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizer.State.ended {
            let touchLocation = gestureReconizer.location(in: mapView)
            let locationCoordinate = mapView.convert(touchLocation,toCoordinateFrom: mapView)
            self.LAT = locationCoordinate.latitude
            self.LONG = locationCoordinate.longitude
            self.SetLocation()
            
            //self.navigationController?.popViewController(animated: true)
            print("Tapped at lat: \(locationCoordinate.latitude) long: \(locationCoordinate.longitude)")
            return
        }
        if gestureReconizer.state != UIGestureRecognizer.State.began {
            return
        }
    }
    
    //MARK: - IBActions
    @IBAction func btnBackPressed(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
        delegate?.DelegateSelectedLocation(lat: self.LAT, long: self.LONG)
    }
}

extension PersonalMapVC : CLLocationManagerDelegate,MKMapViewDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        mapView.removeAnnotation(newPin)
        
        //if let location = locations.last {
        let center = CLLocationCoordinate2D(latitude: LAT, longitude: LONG)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.mapView.setRegion(region, animated: true)
        
        newPin.coordinate = center //center.coordinate
        mapView.addAnnotation(newPin)
        //}
    }
}
