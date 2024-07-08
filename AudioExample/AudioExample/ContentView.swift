//
//  ContentView.swift
//  AudioExample
//
//  Created by Jungjin Park on 2024-07-05.
//

import SwiftUI
import AVKit

struct ContentView: View {
    var audioPlayerManager = AudioPlayerManager()
    @State var isAudioPlaying = false
    // video
    @State var player: AVPlayer?
    
    var body: some View {
        VStack {
            Button(action: {
                if isAudioPlaying {
                    audioPlayerManager.pause()
                } else {
                    audioPlayerManager.play()
                }
                isAudioPlaying.toggle()
            }, label: {
                Text(!isAudioPlaying ? "Play Audio" : "Pause audio")
            })
        }
        .padding()
        .onAppear {
            audioPlayerManager.loadAudio(name: "Small World", withExtension: "mp3")
        }
        VideoPlayer(player: player)
            .frame(height: 220)
            .onAppear {
                guard let videoURL = Bundle.main.url(forResource: "SaturnV", withExtension: "mov") else {
                    print("Video file not found")
                    return
                }
                player = AVPlayer(url: videoURL as URL)
            }
    }
}

#Preview {
    ContentView()
}
