//
//  TimelineCardView.swift
//  VoiceAssistant
//
//  Created by Abhishek on 03/10/25.
//

import SwiftUI
import Combine

struct TimelineCardView: View {
    var entry: RecordedEntry
    @State private var showExpandedView: Bool = false

    var body: some View {
        VStack(alignment: .leading,
               spacing: 15) {
            headerView
            dateView
            subtitleView
        }
        .padding(.leading, 20)
        .padding(.vertical, 20)
        .onTapGesture {
            showExpandedView = !showExpandedView
        }
    }
    
    private var headerView: some View {
        HStack(spacing: 15) {
            Image(systemName: ImageConstants.docText.rawValue)
                .resizable()
                .scaledToFit()
                .frame(width: 12)
                .foregroundStyle(Colors.externalCircleColor)
            Text(entry.title)
                .foregroundStyle(Color.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var dateView: some View {
        HStack(spacing: 15) {
            Image(systemName: ImageConstants.calendar.rawValue)
                .resizable()
                .scaledToFit()
                .frame(width: 15)
                .foregroundStyle(Colors.textColor)
            Text(entry.time.formatted(date: .long, time: .shortened))
                .foregroundStyle(Colors.textColor)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var subtitleView: some View {
        Text(entry.transcribedText)
            .lineLimit(showExpandedView ? nil : 1)
            .multilineTextAlignment(.leading)
    }
}
