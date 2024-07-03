//
//  RotationView.swift
//  Motion
//
//  Created by Jungjin Park on 2024-07-03.
//
//
//  ContentView.swift
//  Motion
//
//  Created by Jungjin Park on 2024-07-03.
//

import SwiftUI
import CoreMotion

struct RotationView: View {
    let motionManager = CMMotionManager()
    let queue = OperationQueue()
    
    @State private var x: Double = 0.0
    @State private var y: Double = 0.0
    @State private var z: Double = 0.0
    
    var body: some View {
        VStack {
            Text("x: \(x)")
            Text("y: \(y)")
            Text("z: \(z)")
        }
        .padding()
        .onAppear {
            motionManager.startGyroUpdates(to: queue) { (data: CMGyroData?, error: Error?) in
                guard let data = data else {
                    print("error: \(error!)")
                    return
                }
                
                let trackMotion: CMRotationRate = data.rotationRate
                motionManager.gyroUpdateInterval = 0.5
                DispatchQueue.main.async {
                    x = trackMotion.x
                    y = trackMotion.y
                    z = trackMotion.z
                }
            }
        }
    }
}

#Preview {
    RotationView()
}
