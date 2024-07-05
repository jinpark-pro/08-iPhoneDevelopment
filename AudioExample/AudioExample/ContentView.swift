//
//  ContentView.swift
//  AudioExample
//
//  Created by Jungjin Park on 2024-07-05.
//

import SwiftUI

struct ContentView: View {
    var audioPlayerManager = AudioPlayerManager()
    @State var isAudioPlaying = false
    
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
    }
}

#Preview {
    ContentView()
}
