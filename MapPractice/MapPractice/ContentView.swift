//
//  ContentView.swift
//  MapPractice
//
//  Created by Jungjin Park on 2024-07-04.
//

import SwiftUI
import MapKit
import CoreLocation

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    
    @State private var searchText = ""
    @State private var searchResults: [MKMapItem] = []
    
    var body: some View {
        NavigationStack {
            VStack {
                if let location = locationManager.location {
                    Map(coordinateRegion: $region,
                        showsUserLocation: true,
                        annotationItems: searchResults) { item in
                        MapPin(coordinate: item.placemark.coordinate)
                    }
                        .onAppear {
                            setRegion(location.coordinate)
                        }
                } else {
                    Text("Locating your position...")
                }
            }
            .onAppear {
                locationManager.requestLocation()
            }
            .searchable(text: $searchText)
            .onChange(of: searchText) { newValue in
                searchAddress(query: newValue)
            }
        }
    }
    
    private func setRegion(_ coordinate: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    }
    
    private func searchAddress(query: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.region = region
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let response = response else {
                print("Search error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            self.searchResults = response.mapItems
            if let firstResult = response.mapItems.first {
                setRegion(firstResult.placemark.coordinate)
            }
        }
    }
}

#Preview {
    ContentView()
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation? = nil
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    func requestLocation() {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        DispatchQueue.main.async {
            self.location = location
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}

extension MKMapItem: Identifiable {
    public var id: UUID {
        return UUID()
    }
}
