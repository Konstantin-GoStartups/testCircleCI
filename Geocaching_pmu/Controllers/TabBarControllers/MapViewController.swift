// 
// MapViewController.swift
//  Geocaching_pmu
//
//  Created by Konstantin Kostadinov on 23.05.20

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    private let mapViewIdentifier = "mapViewIdentifier"
    private let locationManager = CLLocationManager()
    private let regionInMetres:Double = 5000
    private var containers = [Container?]()
    
    private enum Contants {
        static let showSegue = "showAnnotationSegue"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        checkLocationServices()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        checkLocationServices()
        takeContainers()
    }
    
    
    private func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationVerification()
        } else {
//            SVProgressHUD.showError(withStatus: "Трябва да си пуснете локацията")
        }
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    private func checkLocationVerification() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
        case .denied:
            //show alert instructing ho wto turn on permissions
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        case .authorizedAlways:
            break
        }
    }
    
    private func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMetres, longitudinalMeters: regionInMetres)
            mapView.setRegion(region, animated: true)
        }
    }
    
    private func takeContainers() {
//        SVProgressHUD.show()
        guard let userProfile = UserDefaultsData.userProfile else { return }
        if let tempUser = try? UserModel.decode(from: userProfile) {
            if !tempUser.areasUnlocked!.isEmpty{
                let areasFields: [String:Any] = ["id": tempUser.userId]
                print(areasFields)
                RequestManager.takeContainersForAreas(areas: areasFields) { (containers, error) in
                    if let error = error {
                        print(error)
//                        SVProgressHUD.showError(withStatus: error.localizedDescription)
                    } else {
                        print("containers", containers)
                        self.createAnnotations(containers: containers)
                        self.containers = containers
//                        SVProgressHUD.dismiss()
                    }
                }
            }
        }
    }
    
    private func createAnnotations(containers: [Container?]) {
        for container in containers {

            let annotation = MKPointAnnotation()
            let latitude: Double = (container?.coordinates.first as! NSString as NSString).doubleValue
            let longitude: Double = (container?.coordinates.last as! NSString as NSString).doubleValue
            annotation.title = container?.containerDescription
            annotation.coordinate = CLLocationCoordinate2D(latitude: latitude , longitude: longitude )
            mapView.addAnnotation(annotation)
            mapView.reloadInputViews()
        }
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        print("annotation", annotation.coordinate)
        guard annotation is MKAnnotation else { return nil}
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: mapViewIdentifier)
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: mapViewIdentifier)
            annotationView?.canShowCallout = true
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation as? MKAnnotation else { return }
        for container in containers {
            if annotation.title == container?.containerDescription {
                let showItemStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let showItemVC = showItemStoryboard.instantiateViewController(withIdentifier: "ShowContainerViewController") as! ShowContainerViewController
                showItemVC.loadViewIfNeeded()
                showItemVC.container = container
                showItemVC.modalPresentationStyle = .automatic
                showItemVC.modalTransitionStyle = .crossDissolve
                self.present(showItemVC, animated: true, completion: nil)
            }
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMetres, longitudinalMeters: regionInMetres)
        UserDefaultsData.latitude = location.coordinate.latitude as Double
        UserDefaultsData.longitude = location.coordinate.longitude as Double
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationVerification()
    }
}
