//
//  ContentView.swift
//  BindingExample
//
//  Created by Jungjin Park on 2024-07-02.
//

import SwiftUI

struct ContentView: View {
    @State private var message = ""
    
    var body: some View {
        VStack {
            Text("Hello, \(message)")
            DisplayTextField(newVariable: $message)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
