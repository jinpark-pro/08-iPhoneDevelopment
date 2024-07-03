//
//  ContentView.swift
//  Localization
//
//  Created by Jungjin Park on 2024-07-03.
//

import SwiftUI

struct ContentView: View {
    @State var changeColor = false
    @State var message = ""
    
    var placeholder: LocalizedStringKey = "placeholder-label"
    
    let date = Date()
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full // full, long, medium, short
        dateFormatter.timeStyle = .medium
        return dateFormatter
    }()
    
    var body: some View {
        VStack {
            Text(LocalizedStringKey("greeting-label \(message)"))
            // Text, Button 은 LocalizedStringKey 를 직접 넣을 수 있음
            Text("greeting-label \(message)")
            Button("button-label") {
                changeColor.toggle()
            }
            TextField(placeholder, text: $message)
            Text(date, formatter: dateFormatter)
        }
        .padding()
        .background(changeColor ? Color.red : Color.yellow)
    }
}

#Preview("기본 - 한국어") {
    ContentView()
        .environment(\.locale, .init(identifier: "ko"))
}

#Preview("English") {
    ContentView()
        .environment(\.locale, .init(identifier: "en"))
}
#Preview("French") {
    ContentView()
        .environment(\.locale, .init(identifier: "fr"))
}
#Preview("Spanish") {
    ContentView()
        .environment(\.locale, .init(identifier: "es"))
}
