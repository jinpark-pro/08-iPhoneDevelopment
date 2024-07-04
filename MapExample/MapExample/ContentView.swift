//
//  ContentView.swift
//  MapExample
//
//  Created by Jungjin Park on 2024-07-04.
//

import SwiftUI
import MapKit

extension CLLocationCoordinate2D {
    static let paris = CLLocationCoordinate2D(latitude: 48.856613, longitude: 2.352222)
    static let eiffelTower = CLLocationCoordinate2D(latitude: 48.858370, longitude: 2.294481)
    static let louvre = CLLocationCoordinate2D(latitude: 48.860611, longitude: 2.337644)
    static let notreDame = CLLocationCoordinate2D(latitude: 48.852968, longitude: 2.349902)
    static let arcDeTriomphe = CLLocationCoordinate2D(latitude: 48.873792, longitude: 2.295028)
    static let sacreCoeur = CLLocationCoordinate2D(latitude: 48.886705, longitude: 2.343104)
}

struct IdentifiablePlace: Identifiable {
    let id = UUID()
    let name: String
    let location: CLLocationCoordinate2D
    init(lat: Double, long: Double) {
        self.name = ""
        self.location = CLLocationCoordinate2D(
            latitude: lat, longitude: long)
    }
    init(_ name: String, _ location: CLLocationCoordinate2D) {
        self.name = name
        self.location = location
    }
}
struct ContentView: View {
    let locationManager = CLLocationManager()
    
    @State var message = "Map of Paris"
    // iOS 17 이전
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(center: .arcDeTriomphe, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    // iOS 17 이후
    @State private var position: MapCameraPosition = .region(MKCoordinateRegion(center: .arcDeTriomphe, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
    
    let place = IdentifiablePlace(lat: 48.856613, long: 2.352222)
    
    let items = [
        IdentifiablePlace("Paris", .paris),
        IdentifiablePlace("Eiffel Tower", .eiffelTower),
        IdentifiablePlace("Louvre", .louvre),
        IdentifiablePlace("Notre Dame", .notreDame),
        IdentifiablePlace("Arc De Triomphe", .arcDeTriomphe),
        IdentifiablePlace("Sacre Coeur", .sacreCoeur)
    ]
    
    let places: [(String, CLLocationCoordinate2D)] = [
        ("Paris", .paris),
        ("Eiffel Tower", .eiffelTower),
        ("Louvre", .louvre),
        ("Notre Dame", .notreDame),
        ("Arc De Triomphe", .arcDeTriomphe),
        ("Sacre Coeur", .sacreCoeur)
    ]
    var body: some View {
        VStack {
            // iOS 17 이전
            Map(coordinateRegion: $region, annotationItems: [place]) { place in
                MapMarker(coordinate: place.location, tint: Color.purple)
            }
            Map(coordinateRegion: $region, annotationItems: items) { place in
                MapPin(coordinate: place.location, tint: Color.purple)
            }
            // iOS 17 이후
            Map(position: $position) {
                MapPolygon(coordinates: [.eiffelTower, .louvre, .notreDame])
                    .stroke(.purple.opacity(0.7), lineWidth: 5)
                    .foregroundStyle(.purple.opacity(0.7))
                ForEach(places, id: \.0) { place in
                    Annotation(place.0, coordinate: place.1) {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.purple)
                            .background(.white)
                            .clipShape(Circle())
                    }
                }
            }
            TextEditor(text: $message)
                .frame(width: .infinity, height: 100)
        }
        .onAppear {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = kCLDistanceFilterNone
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
