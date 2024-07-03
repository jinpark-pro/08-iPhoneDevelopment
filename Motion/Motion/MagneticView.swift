//
//  MagneticView.swift
//  Motion
//
//  Created by Jungjin Park on 2024-07-03.
//

import SwiftUI
import CoreMotion

struct MagneticView: View {
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
        .navigationTitle("Magnetic")
        .onAppear {
            motionManager.startMagnetometerUpdates(to: queue) { (data: CMMagnetometerData?, error: Error?) in
                guard let data = data else {
                    print("error: \(error!)")
                    return
                }
                
                let trackMotion: CMMagneticField = data.magneticField
                motionManager.magnetometerUpdateInterval = 1
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
    MagneticView()
}
