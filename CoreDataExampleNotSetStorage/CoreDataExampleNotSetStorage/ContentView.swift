//
//  ContentView.swift
//  CoreDataExampleNotSetStorage
//
//  Created by Jungjin Park on 2024-07-02.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var petName = ""
    @State var petBreed = ""
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Animal.name, ascending: true)], animation: .default)
    private var animals: FetchedResults<Animal>
    
    var body: some View {
        VStack {
            TextField("Enter pet name", text: $petName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Enter pet breed", text: $petBreed)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Save") {
                let pet = Animal(context: viewContext)
                pet.name = petName
                pet.breed = petBreed
                do {
                    try viewContext.save()
                } catch {
                    
                }
                petName = ""
                petBreed = ""
            }
            
            List {
                ForEach(animals, id: \.self) { pet in
                    VStack(alignment: .leading) {
                        Text(pet.name ?? "")
                        Text(pet.breed ?? "")
                    }
                }
            }
        }
        .padding()
    }
}

//#Preview {
//    ContentView(coreDM: CoreDataManager())
//}
