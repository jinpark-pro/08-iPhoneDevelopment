//
//  DeviceMotionView.swift
//  Motion
//
//  Created by Jungjin Park on 2024-07-03.
//

import SwiftUI
import CoreMotion

struct DeviceMotionView: View {
    let motionManager = CMMotionManager()
    let queue = OperationQueue()
    
    @State private var pitch: Double = 0.0
    @State private var yaw: Double = 0.0
    @State private var roll: Double = 0.0
    
    var body: some View {
        VStack {
            Text("pitch: \(pitch)")
            Text("yaw: \(yaw)")
            Text("roll: \(roll)")
        }
        .navigationTitle("DeviceMotion")
        .onAppear {
            motionManager.startDeviceMotionUpdates(to: queue) { (data: CMDeviceMotion?, error: Error?) in
                guard let data = data else {
                    print("error: \(error!)")
                    return
                }
                
                let trackMotion: CMAttitude = data.attitude
                motionManager.deviceMotionUpdateInterval = 1
                DispatchQueue.main.async {
                    pitch = trackMotion.pitch
                    yaw = trackMotion.yaw
                    roll = trackMotion.roll
                }
            }
        }
    }
}

#Preview {
    DeviceMotionView()
}
