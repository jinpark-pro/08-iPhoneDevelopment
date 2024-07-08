//
//  ContentView.swift
//  Text2Speech
//
//  Created by Jungjin Park on 2024-07-08.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    let audio = AVSpeechSynthesizer()
    
    @State var convertText = AVSpeechUtterance(string: "")
    @State var textToRead = "This is a test of the emergency broadcast system. Can you hear me?"
    @State var sliderValue: Float = 0.0
    
    var body: some View {
        VStack {
            TextEditor(text: $textToRead)
                .frame(width: 250, height: 200)
            Slider(value: $sliderValue, in: 0...1)
            Button {
                convertText = AVSpeechUtterance(string: textToRead)
                convertText.rate = sliderValue
                
//                let voice = AVSpeechSynthesisVoice(language: "en-GB")
                let voice = AVSpeechSynthesisVoice(identifier: "om.apple.ttsbundle.siri_female_en-GB_compact")
                convertText.voice = voice
                
                audio.speak(convertText)
            } label: {
                Text("Read Text Out Loud")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
