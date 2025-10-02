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
    
    var body: some View {
        NavigationStack {
            ZStack {
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
            .navigationTitle(viewModel.strings.title)
        }
        .preferredColorScheme(.dark)
    }

    private func onDeleteTap(_ indexSet: IndexSet) {
        for index in indexSet {
            modelContext.delete(entries[index])
        }
    }
}

#Preview {
    JournalTimelineView()
}
