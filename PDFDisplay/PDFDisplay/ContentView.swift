//
//  ContentView.swift
//  PDFDisplay
//
//  Created by Jungjin Park on 2024-07-08.
//

import SwiftUI
import PDFKit

struct ContentView: View {
    let fileURL = Bundle.main.url(forResource: "example", withExtension: "pdf")
    var body: some View {
        VStack {
            ViewMe(url: fileURL!)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

struct ViewMe: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: UIViewRepresentableContext<ViewMe>) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: url)
        pdfView.displayMode = .singlePageContinuous
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {
        
    }
}
