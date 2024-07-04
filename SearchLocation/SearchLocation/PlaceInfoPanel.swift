//
//  PlaceInfoPanel.swift
//  SearchLocation
//
//  Created by Jungjin Park on 2024-07-04.
//

import SwiftUI

struct PlaceInfoPanel: View {
    var viewModel: MapViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.selectedPlace?.name ?? "-")
                .font(.headline)
            Text(viewModel.selectedPlace?.placemark.title ?? "")
                .font(.subheadline)
            
            HStack {
                Button(action: {
                    viewModel.getDirection()
                }) {
                    Label("Direction", systemImage: "arrow.triangle.turn.up.right.diamond")
                }
                Spacer()
                Button(action: {
                    viewModel.shareLocation()
                }) {
                    Label("Share", systemImage: "square.and.arrow.up")
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

#Preview {
    PlaceInfoPanel(viewModel: MapViewModel())
}
