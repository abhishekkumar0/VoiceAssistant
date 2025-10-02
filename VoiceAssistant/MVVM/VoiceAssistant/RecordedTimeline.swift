//
//  RecordedTimeline.swift
//  VoiceAssistant
//
//  Created by Abhishek on 02/10/25.
//

import Foundation
import SwiftData

@Model
class RecordedEntry {
    var title: String
    var transcribedText: String
    var time: Date

    init(title: String, transcribedText: String, time: Date = .now) {
        self.title = title
        self.transcribedText = transcribedText
        self.time = time
    }
}
