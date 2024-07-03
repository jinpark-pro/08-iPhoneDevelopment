//
//  ContentView.swift
//  SearchExample
//
//  Created by Jungjin Park on 2024-07-03.
//

import SwiftUI

enum Scope {
    case all
    case favorites
    case recent
}
struct ContentView: View {
    @State var searchScope: Scope = .all
    @State var searchText = ""
    
    let petArray = ["Cat", "Dog", "Fish", "Donkey", "Canary", "Camel", "Frog"]

    
    var body: some View {
        NavigationStack {
            petListView(animals: petArray)
        }
        .searchScopes($searchScope) {
            Text("All").tag(Scope.all)
            Text("Favorites").tag(Scope.favorites)
            Text("Recent").tag(Scope.recent)
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Look for a pet") {
            Text("Singing").searchCompletion("Canary")
            Divider()
            ForEach(petArray.filter { $0.hasPrefix(searchText) }, id: \.self) { name in
                Text(name)
            }
        }
    }
}

#Preview {
    ContentView()
}

struct petListView: View {
    let animals: [String]
    var body: some View {
        List(animals, id: \.self) { animal in
            Text(animal)
        }
        .listStyle(.plain)
    }
}
