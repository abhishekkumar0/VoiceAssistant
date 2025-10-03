//
//  JournalTimelineViewModel.swift
//  VoiceAssistant
//
//  Created by Abhishek on 02/10/25.
//

import Foundation
import SwiftUI
import Combine

final class JournalTimelineViewModel: ObservableObject {
    let strings = Strings()
}

extension JournalTimelineViewModel {
    struct Strings {
        let title: String = "Journals"
        let noRecordAvailable: String = "No Record Available"
        let startRecording: String = "Start Recording"
    }
}
