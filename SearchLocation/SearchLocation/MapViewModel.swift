//
//  MapView.swift
//  SearchLocation
//
//  Created by Jungjin Park on 2024-07-04.
//

import SwiftUI
import MapKit

@Observable
class MapViewModel {
    var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    var searchText = ""
    var mapStyle: MapStyle = .standard
}
