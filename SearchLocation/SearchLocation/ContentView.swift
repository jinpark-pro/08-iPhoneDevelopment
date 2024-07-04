//
//  ContentView.swift
//  SearchLocation
//
//  Created by Jungjin Park on 2024-07-04.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State var viewModel = MapViewModel()
    @State var style = 0
    
    var body: some View {
        NavigationStack {
            Picker("", selection: $style) {
                Text("Standard").tag(0)
                Text("Imagery").tag(1)
                Text("Hybrid").tag(2)
            }
            .pickerStyle(.segmented)
            Map(position: $viewModel.cameraPosition) {
                ForEach(viewModel.searchResults, id: \.self) { place in
                    Annotation(place.name ?? "", coordinate: place.placemark.coordinate) {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundStyle(.red)
                            .background(.white)
                            .clipShape(Circle())
                    }
                }
            }
                .mapControls {
                    MapUserLocationButton()
                }
                .mapStyle(viewModel.mapStyle)
                .navigationTitle("Search Location")
                .searchable(text: $viewModel.searchText)
                .onChange(of: style) {
                    switch style {
                    case 0:
                        viewModel.mapStyle = .standard
                    case 1:
                        viewModel.mapStyle = .imagery
                    case 2:
                        viewModel.mapStyle = .hybrid
                    default:
                        viewModel.mapStyle = .standard
                    }
                }
                .onSubmit(of: .search) {
                    viewModel.searchLocation()
                }
        }
    }
}

#Preview {
    ContentView()
}
