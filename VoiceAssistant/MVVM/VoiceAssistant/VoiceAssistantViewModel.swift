//
//  VoiceAssistentViewModel.swift
//  VoiceAssistant
//
//  Created by Abhishek on 02/10/25.
//

import SwiftUI
import Combine
import SwiftData

final class VoiceAssistantViewModel: ObservableObject {
    @Published var moveToJournalTimeline: Bool = false
    @Published var isAssistantListening: Bool = false
    private var manager: VoiceAssistantManagerProtocol = DependencyContainer.shared.resolveSpeechManager()
    let strings = Strings()

    func toggleListening(with context: ModelContext) {
        if manager.isRunning {
            stopListening(context)
        } else {
            startListening()
        }
    }

    private func startListening() {
        Task { @MainActor [weak self] in
            guard let sSelf = self else { return }
            do {
                try sSelf.manager.startListening()
                sSelf.isAssistantListening = true
            } catch {
                sSelf.isAssistantListening = false
            }
        }
    }

    private func stopListening(_ context: ModelContext) {
        manager.stopListening()
        DispatchQueue.main.async {[weak self] in
            self?.isAssistantListening = false
        }
        guard !manager.transcribedText.isEmpty else { return }
        saveTranscribedText(modelContext: context, manager.transcribedText)
    }

    private func saveTranscribedText(modelContext: ModelContext, _ transcribedText: String) {
        let entry = RecordedEntry(title: generateTitle(from: transcribedText),
                                  transcribedText: transcribedText)
        modelContext.insert(entry)
    }

    private func generateTitle(from text: String) -> String {
        let words = text.split(separator: " ")
        let firstWords = words.prefix(5)
        return firstWords.joined(separator: " ").trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

extension VoiceAssistantViewModel {
    struct Strings {
        var title: String = "Voice Assistant"
        var subtitle: String = "Speak naturally, get instant responses"
        var tapToBegin: String = "Tap the microphone to begin"
        var ready: String = "READY"
        var listening: String = "LISTENING"
        var speakNow: String = "Speak now..."
        var viewHistory: String = "View History"
    }
}
