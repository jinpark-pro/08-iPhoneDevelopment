//
//  DisplayTextField.swift
//  BindingExample
//
//  Created by Jungjin Park on 2024-07-02.
//

import SwiftUI

struct DisplayTextField: View {
    @Binding var newVariable: String
    
    var body: some View {
        HStack {
            Text("Send a greeting:")
            TextField("Type a message here", text: $newVariable)
        }
    }
}

#Preview {
    DisplayTextField(newVariable: .constant("test"))
}
