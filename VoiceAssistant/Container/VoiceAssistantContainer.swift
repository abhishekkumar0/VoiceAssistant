//
//  VoiceAssistantContainer.swift
//  VoiceAssistant
//
//  Created by Abhishek on 02/10/25.
//

final class DependencyContainer {
    static let shared = DependencyContainer()
    
    private init() {}

    func resolveSpeechManager() -> VoiceAssistantManagerProtocol {
        VoiceAssistantManager()
    }
}
