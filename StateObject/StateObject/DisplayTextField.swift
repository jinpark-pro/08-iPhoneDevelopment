//
//  DisplayTextField.swift
//  StateObject
//
//  Created by Jungjin Park on 2024-07-02.
//

import SwiftUI

struct DisplayTextField: View {
    @EnvironmentObject var creature: AnimalModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Name:")
                TextField("Type a name here", text: $creature.name)
            }
            HStack {
                Text("Breed:")
                TextField("Type a breed here", text: $creature.breed)
            }
            HStack {
                Text("Age:")
                Slider(value: $creature.age, in: 0...20)
            }
            HStack {
                Text("Weight:")
                Slider(value: $creature.weight, in: 0...200)
            }
        }
    }
}
