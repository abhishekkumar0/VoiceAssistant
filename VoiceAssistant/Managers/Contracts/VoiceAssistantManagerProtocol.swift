//
//  VoiceAssistantManagerProtocol.swift
//  VoiceAssistant
//
//  Created by Abhishek on 02/10/25.
//

import Foundation
import Speech

protocol VoiceAssistantManagerProtocol {
    var isRunning: Bool { get }
    var transcribedText: String { get }

    func requestPermissions(completion: @escaping (Bool) -> Void)
    func startListening() throws
    func stopListening()
}
