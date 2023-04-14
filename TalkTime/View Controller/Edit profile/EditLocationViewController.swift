//
//  GoogleMapsViewController.swift
//  TalkTime
//
//  Created by Talor Levy on 3/9/23.
//

import UIKit
import GoogleMaps
import CoreLocation


class EditLocationViewController: UIViewController {

    var editLocationViewModel: EditLocationViewModel?
    var locationManager: CLLocationManager?
    var marker: GMSMarker?
    
    
    //MARK: - @IBOutlet

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var googleMap: GMSMapView!
    @IBOutlet weak var saveLocationButton: UIButton!
    

    //MARK: - override

    override func viewDidLoad() {
        super.viewDidLoad()
        configureClassProperties()
        localizeUI()
        obtainPermission()
        findUserLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        localizeUI()
    }
    
    
    //MARK: - functions

    func configureClassProperties() {
        editLocationViewModel = EditLocationViewModel(firebaseDBManager: FirebaseDatabaseManager.shared, vc: self)
        locationManager = CLLocationManager()
        marker = GMSMarker()
    }
    
    func localizeUI() {
        saveLocationButton.setTitle(GoogleMapsString.saveLocationButton.localized.firstUppercased, for: .normal)
    }

    
    //MARK: - @IBAction

    @IBAction func saveLocationButtonAction(_ sender: Any) {
        guard let uid = LocalData.shared.currentUser?.uid, let latitude = marker?.position.latitude,
              let longitude = marker?.position.longitude else { return }
        let userUpdate = ["latitude": latitude, "longitude": longitude]
        editLocationViewModel?.updateUser(uid: uid, userDictionary: userUpdate) { result in
            switch result {
            case .success():
                print("Success updating user at GoogleMapsViewController")
//                LocalData.shared.user?.location?.latitude = latitude
//                LocalData.shared.user?.location?.longitude = longitude
                self.navigationController?.popViewController(animated: true)
            case .failure(let error):
                print("Error updating user at GoogleMapsViewController: \(error.localizedDescription)")
                self.navigationController?.popViewController(animated: true)
            }
        }

    }
}


// MARK: - UISearchBarDelegate

extension EditLocationViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchQuery = searchBar.text else { return }
        googleMap.clear()
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(searchQuery) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            guard error == nil else {
                print("Error during geocoding: \(error!)")
                return
            }
            guard let placemark = placemarks?.first else {
                print("No placemarks found for search query: \(searchQuery)")
                return
            }
            let marker = GMSMarker(position: placemark.location!.coordinate)
            self.marker = marker
            marker.title = placemark.name
            marker.snippet = placemark.locality
            marker.map = self.googleMap

            let camera = GMSCameraPosition.camera(withTarget: placemark.location!.coordinate, zoom: 15)
            self.googleMap.animate(to: camera)
        }
    }
}


//MARK: - CLLocationManagerDelegate

extension EditLocationViewController: CLLocationManagerDelegate {
    
    func obtainPermission() {
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
    }

    func findUserLocation() {
        if LocalData.shared.currentUser?.location?.latitude == 0.0 && LocalData.shared.currentUser?.location?.latitude == 0.0 {
            locationManager?.requestLocation()
        } else {
            if let userLocation = LocalData.shared.currentUser?.location {
                let latitude = userLocation.latitude
                let longitude = userLocation.longitude
                let location = CLLocation(latitude: latitude, longitude: longitude)
                marker?.position = location.coordinate
                marker?.title = "Your Location"
                marker?.map = googleMap
                let camera = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 15.0)
                googleMap.camera = camera
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        marker?.position = location.coordinate
        marker?.title = "Your Location"
        marker?.map = googleMap
        let camera = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 15.0)
        googleMap.camera = camera
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error.localizedDescription)")
    }
}


//import UIKit
//import GooglePlaces
//
//class MapViewController: UIViewController {
//
//    // Declare a variable to hold the user's location
//    var userLocation: String?
//    
//    // Declare a variable to hold the Google Places API client
//    var placesClient: GMSPlacesClient!
//    
//    // Declare outlets for the search bar and save button
//    @IBOutlet weak var searchBar: UISearchBar!
//    @IBOutlet weak var saveButton: UIButton!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Initialize the Google Places API client
//        placesClient = GMSPlacesClient.shared()
//        
//        // Set the delegate for the search bar
//        searchBar.delegate = self
//    }
//    
//    @IBAction func saveLocation(_ sender: Any) {
//        // Save the user's location to Firebase
//        // ...
//    }
//}
//
//extension MapViewController: UISearchBarDelegate {
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        // Perform a text search for the place that the user has typed in the search bar
//        let searchRequest = GMSAutocompleteQueryFragment.init(query: searchBar.text!)
//        placesClient.findAutocompletePredictions(fromQuery: searchRequest) { (results, error) in
//            if let error = error {
//                print("Error searching for place: \(error.localizedDescription)")
//                return
//            }
//            
//            guard let results = results else { return }
//            
//            // Loop through the search results and determine the type of place that the user has typed
//            var hasCountry = false
//            var hasCity = false
//            var hasAddress = false
//            for result in results {
//                if result.types.contains("country") {
//                    hasCountry = true
//                }
//                if result.types.contains("locality") || result.types.contains("neighborhood") {
//                    hasCity = true
//                }
//                if result.types.contains("street_address") {
//                    hasAddress = true
//                }
//            }
//            
//            // Save the user's location based on what they have typed
//            if hasCountry {
//                self.userLocation = searchBar.text
//            } else if hasCity || hasAddress {
//                // If there are multiple results, use the first one
//                let firstResult = results.first
//                self.userLocation = firstResult?.formattedFullText
//            } else {
//                print("Unknown location type")
//            }
//        }
//    }
//}
