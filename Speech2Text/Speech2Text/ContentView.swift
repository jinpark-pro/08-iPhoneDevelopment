//
//  ContentView.swift
//  Speech2Text
//
//  Created by Jungjin Park on 2024-07-08.
//

import SwiftUI
import Speech

struct ContentView: View {
    let audioEngine = AVAudioEngine()
    let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-CA"))
    
    @State var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    @State var recognitionTask: SFSpeechRecognitionTask?
    
    @State var message = ""
    @State var buttonStatus = true
    @State var newColor: Color = .white
    
    var body: some View {
        VStack(spacing: 25) {
            Button {
                recognizeSpeech()
            } label: {
                Text("Start recording")
            }
            TextField("Spoken text appears here", text: $message)
            Button {
                message = ""
                newColor = .white
                stopSpeech()
            } label: {
                Text("Stop recording")
            }
        }
        .background(newColor)
    }
    // MARK: - Methods
    func checkSpokenCommand(commandString: String) {
        switch commandString {
        case "Purple":
            newColor = .purple
        case "Green":
            newColor = .green
        case "Yellow":
            newColor = .yellow
        default:
            newColor = .white
        }
    }
 
    func recognizeSpeech() {
        message = "Start recoding"
        let node = audioEngine.inputNode
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        recognitionRequest?.shouldReportPartialResults = true
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
            recognitionRequest?.append(buffer)
        }
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            return print(error)
        }
        guard let recognizeMe = SFSpeechRecognizer() else { return }
        if !recognizeMe.isAvailable {
            return
        }
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest ?? SFSpeechAudioBufferRecognitionRequest.init(), resultHandler: { result, error in
            if let result = result {
                let transcribedString = result.bestTranscription.formattedString
                message = transcribedString
                checkSpokenCommand(commandString: transcribedString)
            } else if let error = error {
                print(error)
            }
        })
    }
    
    func stopSpeech() {
        audioEngine.stop()
        recognitionTask?.cancel()
        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionRequest?.endAudio()
    }
}
