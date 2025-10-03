//
//  ViewExt.swift
//  VoiceAssistant
//
//  Created by Abhishek on 03/10/25.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
