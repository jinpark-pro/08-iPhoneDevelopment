//
//  ContentView.swift
//  WebKitExample
//
//  Created by Jungjin Park on 2024-07-08.
//

import SwiftUI
import WebKit

struct ContentView: View {
    var body: some View {
        VStack {
            WebView(url: URL(string: "https://www.apple.com")!)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: UIViewRepresentableContext<WebView>) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
