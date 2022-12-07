//
//  UserListMapVC.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 27/05/22.
//

import UIKit
import MapKit
import CoreLocation
import JXSegmentedView

class UserListMapVC: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    
    @IBOutlet var txtSearch: UITextField!
    
    var userTrackingButton: MKUserTrackingButton!
    var scaleView: MKScaleView!
    var locationManager = CLLocationManager()
    //var mapData: [HomeThumnails]?
    var param : [String: Any] = ["":""]
    var viewPopup = MapPopupView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        setupCompassButton()
        setupUserTrackingButtonAndScaleView()
        registerAnnotationViewClasses()
        
        mapView.delegate = self
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //getMapApi(param: param)
    }
    
    private func setupCompassButton() {
        let compass = MKCompassButton(mapView: mapView)
        compass.compassVisibility = .visible
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: compass)
        mapView.showsCompass = false
    }
    
    private func registerAnnotationViewClasses() {
        mapView.register(ClusterAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
    }
    func setupUI () {
        self.mapView.cornerRadius = 10.0
        
    }
    
    private func setupUserTrackingButtonAndScaleView() {
        mapView.showsUserLocation = true
        
        userTrackingButton = MKUserTrackingButton(mapView: mapView)
        userTrackingButton.isHidden = true // Unhides when location authorization is given.
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: userTrackingButton)
        
        // By default, `MKScaleView` uses adaptive visibility, so it only displays when zooming the map.
        // This is behavior is confirgurable with the `scaleVisibility` property.
        scaleView = MKScaleView(mapView: mapView)
        scaleView.legendAlignment = .trailing
        view.addSubview(scaleView)
        
        let stackView = UIStackView(arrangedSubviews: [scaleView, userTrackingButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
                                     stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)])
    }
    
    //MARK: - Action
    @IBAction func btnBackPressed(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSearchPressed(_ sender : UIButton) {
    }
}

extension UserListMapVC : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        //let index = (mapView.annotations as NSArray).index(of: annotation)
        
        let reuseID = "Location"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID)
        if annotationView == nil {
            let pin = MapAnnotationView(annotation: annotation,
                                        reuseIdentifier: reuseID)
            /*let data = mapData?[index] ?? HomeThumnails()
             if let _ = data.user_tags?.contains(where: {$0.name ?? "" == "Gold"}){
             pin.imageView.borderColor = .appOrange
             }else{
             pin.imageView.borderColor = .white
             }
             pin.imageView.setImage(url: data.user_image ?? "")//image = UIImage(named: "ic_home_artist")
             artist.thumbnail = data*/
            
            pin.imageView.borderColor = .white
            pin.imageView.image = UIImage(named: "img_DummyUser")
            pin.canShowCallout = true
            annotationView = pin
            let artist = MapPopupView(frame: CGRect(x: 0, y: 0, width: 320, height: 115))
            pin.detailCalloutAccessoryView = artist
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
}

extension UserListMapVC {
    
    func getMapApi(param: [String: Any]){
        
        let anno2 = MKPointAnnotation();
        anno2.title = "Pin Me"
        anno2.coordinate = CLLocationCoordinate2D(latitude: 26.9124 , longitude: 75.7873);
        self.mapView.addAnnotation(anno2);
        
        /* let _ = HomeTabRepo().geMapData(view: self.view, param: param).subscribe(onNext: { homeAllData in
         self.mapData = homeAllData
         
         self.mapView.removeAnnotations(self.mapView.annotations)
         for i in (0..<self.mapData!.count) {
         
         let anno2 = MKPointAnnotation()
         anno2.coordinate = CLLocationCoordinate2D(latitude: ((self.mapData?[i].latitude ?? "0") as NSString).doubleValue , longitude: ((self.mapData?[i].longitude ?? "0") as NSString).doubleValue);
         anno2.title = self.mapData?[i].name
         self.mapView.addAnnotation(anno2)
         }
         self.mapView.delegate = self
         //            let anno2 = MKPointAnnotation();
         //            anno2.title = "Navdeep Sir"
         //            anno2.coordinate = CLLocationCoordinate2D(latitude: 26.9124 , longitude: 75.7873);
         //            self.mapView.addAnnotation(anno2);
         }, onError: { error in
         self.view.makeToast(error.localizedDescription)
         }).disposed(by: disposeBag) */
    }
    
    func getMapApiWithFilter(param: [String: Any]){
        
        
    }
    
}

extension UserListMapVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        let locationAuthorized = status == .authorizedWhenInUse
        userTrackingButton.isHidden = !locationAuthorized
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last! as CLLocation
        
        let anno = MKPointAnnotation();
        //anno.title = "Pin Me"
        let lat = location.coordinate.latitude
        let long = location.coordinate.longitude
        anno.coordinate = CLLocationCoordinate2D(latitude: lat , longitude: long)
        self.mapView.addAnnotation(anno)
        
        let anno2 = MKPointAnnotation();
        //anno2.title = "Hey Me"
        anno2.coordinate = CLLocationCoordinate2D(latitude: 21.1702 , longitude: 72.8311)
        self.mapView.addAnnotation(anno2)
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if view.annotation is MKUserLocation {
            mapView.deselectAnnotation(view.annotation, animated: false)
            return
        }
    }
}

extension UserListMapVC : UITextFieldDelegate {
}

extension UserListMapVC: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}
