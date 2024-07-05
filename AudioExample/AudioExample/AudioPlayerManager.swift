//
//  AudioPlayerManager.swift
//  AudioExample
//
//  Created by Jungjin Park on 2024-07-05.
//

import AVFoundation

class AudioPlayerManager {
    var audioPlayer: AVAudioPlayer?
    
    func loadAudio(name fileName: String, withExtension ext: String) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: ext) else {
            print("Audio file not found")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
        } catch {
            print("Error loading audio: \(error.localizedDescription)")
        }
    }
    
    func play() {
        audioPlayer?.play()
    }
    
    func pause() {
        audioPlayer?.pause()
    }
    func stop() {
        audioPlayer?.stop()
    }
}
