//
//  JournalTimelineView.swift
//  VoiceAssistant
//
//  Created by Abhishek on 02/10/25.
//

import SwiftUI
import SwiftData

struct JournalTimelineView: View {
    @StateObject var viewModel: JournalTimelineViewModel = JournalTimelineViewModel()
    @Query var entries: [RecordedEntry]
    @Environment(\.modelContext)
    var modelContext
    @Environment(\.dismiss)
    private var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                if entries.isEmpty {
                    errorView
                } else {
                    Color.black
                        .ignoresSafeArea()
                    List {
                        ForEach(entries) { entry in
                            TimelineCardView(entry: entry)
                        }
                        .onDelete(perform: onDeleteTap)
                    }
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle(viewModel.strings.title)
        }
        .preferredColorScheme(.dark)
    }

    private func onDeleteTap(_ indexSet: IndexSet) {
        for index in indexSet {
            modelContext.delete(entries[index])
        }
    }

    private var errorView: some View {
        VStack(spacing: 32) {
            Text(viewModel.strings.noRecordAvailable)
            startRecordingButton
        }
    }

    private var startRecordingButton: some View {
        Button {
            dismiss()
        } label: {
            HStack {
                Text(viewModel.strings.startRecording)
                    .symbolRenderingMode(.multicolor)
                    .foregroundStyle(Colors.textColor)
                    .font(.system(size: 15))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Colors.textColor, lineWidth: 2)
            )
            .padding(.horizontal, 30)
        }
    }
}

#Preview {
    JournalTimelineView()
}
