//
//  ContentView.swift
//  ReadWrite
//
//  Created by Jungjin Park on 2024-07-02.
//

import SwiftUI

struct ContentView: View {
    @State var createText = "Text here.."
    @State var displayText = ""
    
    let placeholder = "Text here.."
    @State var userCreated = false
    @FocusState var textFieldFocused: Bool
    var textDisabled: Bool {
        placeholder == createText && !textFieldFocused && !userCreated
    }
    var body: some View {
        VStack {
            TextEditor(text: $createText)
                .foregroundStyle(textDisabled ? .gray : .black)
                .focused($textFieldFocused)
                .onChange(of: textFieldFocused) {
                    if textFieldFocused, createText == placeholder, !userCreated {
                        createText = ""
                        userCreated = true
                    } else if !textFieldFocused, createText.isEmpty {
                        createText = placeholder
                        userCreated = false
                    }
                }
            HStack {
                Button(action: {
                    let fm = FileManager.default
                    let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
                    let url = urls.last?.appendingPathComponent("file.txt")
                    do {
                        try createText.write(to: url!, atomically: true, encoding: String.Encoding.utf8)
                    } catch {
                        print("File writing error")
                    }
                }) {
                    Text("Write File")
                }
                Button(action: {
                    let fm = FileManager.default
                    let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
                    let url = urls.last?.appendingPathComponent("file.txt")
                    do {
                        let fileContent = try String(contentsOf: url!, encoding: String.Encoding.utf8)
                        displayText = fileContent
                    } catch {
                        print("File reading error")
                    }
                }) {
                    Text("Read File")
                }
            }
            .padding()
            TextEditor(text: $displayText)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
