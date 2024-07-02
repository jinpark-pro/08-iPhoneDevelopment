//
//  ContentView.swift
//  StateObject
//
//  Created by Jungjin Park on 2024-07-02.
//

import SwiftUI

class AnimalModel: ObservableObject {
    @Published var name: String = ""
    @Published var breed: String = ""
    @Published var age: Double = 0.0
    @Published var weight: Double = 0.0
}

struct ContentView: View {
    @StateObject var cat = AnimalModel()
    
    var body: some View {
        VStack {
            Text("Hello, \(cat.name)")
            Text("Breed, \(cat.breed)")
            Text("Age, \(cat.age)")
            Text("Weight, \(cat.weight)")
            DisplayTextField(creature: cat)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
