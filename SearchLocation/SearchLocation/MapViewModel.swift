//
//  MapView.swift
//  SearchLocation
//
//  Created by Jungjin Park on 2024-07-04.
//

import SwiftUI
import MapKit

@Observable
class MapViewModel: NSObject, CLLocationManagerDelegate {
    var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    var searchText = ""
    var mapStyle: MapStyle = .standard
    var searchResults: [MKMapItem] = []
    var selectedPlace: MKMapItem?
    var route: MKRoute?
    
    private var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func searchLocation() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.resultTypes = .pointOfInterest
        
        let search = MKLocalSearch(request: request)
        
        search.start { [weak self] response, error in
            guard let response = response else { return }
            self?.searchResults = response.mapItems
            
        }
    }
    
    func getDirection() {
        let request = MKDirections.Request()
        request.source = MKMapItem.forCurrentLocation()
        request.destination = selectedPlace!
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        directions.calculate { [weak self] response, error in
            guard let response = response else { return }
            self?.route = response.routes.first
        }
    }
    
    func shareLocation() {
        print("share location")
    }
    
    // MADK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Failed to get location: \(error.localizedDescription)")
    }
}
