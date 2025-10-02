//
//  VoiceAssistantApp.swift
//  VoiceAssistant
//
//  Created by Abhishek on 02/10/25.
//

import SwiftUI
import SwiftData

@main
struct VoiceAssistantApp: App {
    var body: some Scene {
        WindowGroup {
            VoiceAssistantView(viewModel: VoiceAssistantViewModel())
        }
        .modelContainer(for: RecordedEntry.self)
    }
}
