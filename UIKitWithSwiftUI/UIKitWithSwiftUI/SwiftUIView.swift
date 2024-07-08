//
//  SwiftUIView.swift
//  UIKitWithSwiftUI
//
//  Created by Jungjin Park on 2024-07-08.
//

import SwiftUI

struct SwiftUIView: View {
    var name: String
    var body: some View {
        Text("Hello, \(name)")
            .navigationTitle("SwiftUIView")
    }
}

#Preview {
    SwiftUIView(name: "John")
}
