//
//  ContentView.swift
//  Concurrency
//
//  Created by Jungjin Park on 2024-07-01.
//

import SwiftUI

enum Response {
    case success
}

struct ContentView: View {
    @State var message = ""
    @State var sliderValue = 0.0
    
    var body: some View {
        VStack {
            Button("Click Me") {
                let startTime = NSDate()
                callFucntion()
                let endTime = NSDate()
                message = "Completed in \(endTime.timeIntervalSince(startTime as Date)) seconds"
            }
            Spacer()
            Slider(value: $sliderValue)
            Text("Message = \(message)")
        }
        .padding()
    }
    
    func doSomething() async throws -> Response {
        Thread.sleep(forTimeInterval: 5)
        print("sleep done")
        return Response.success
    }
    
    func callFucntion() {
        Task(priority: .high) {
            do {
                _ = try await doSomething()
            } catch {
                //
            }
        }
    }
}

#Preview {
    ContentView()
}
