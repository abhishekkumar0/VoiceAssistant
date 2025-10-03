//
//  VoiceAssistantView.swift
//  VoiceAssistant
//
//  Created by Abhishek on 02/10/25.
//

import SwiftUI
import Combine

struct VoiceAssistantView: View {
    @ObservedObject var viewModel: VoiceAssistantViewModel
    @EnvironmentObject var details: UserDetails
    @Environment(\.modelContext)
    private var modelContext
 
    var body: some View {
        VStack {
            contentView
                .navigationDestination(isPresented: $viewModel.moveToJournalTimeline) {
                    JournalTimelineView()
                }
                .navigationBarBackButtonHidden()
        }
    }

    private var contentView: some View {
        VStack(spacing: 48) {
            headerView
            microphoneButtonView
            bottomView
            viewHistory
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Colors.backgroundColor)
        .ignoresSafeArea()
    }
    
    private var headerView: some View {
        VStack(spacing: 8) {
            Text(viewModel.strings.title)
                .font(.system(size: 48, design: .rounded))
                .foregroundStyle(.clear)
                .overlay(LinearGradient(colors: [Colors.externalCircleColor, .white],
                                        startPoint: .leading,
                                        endPoint: .trailing))
                .mask {
                    Text(viewModel.strings.title)
                        .font(.system(size: 48, design: .rounded))
                }
            Text(viewModel.strings.subtitle)
                .foregroundStyle(Colors.textColor)
        }
    }
    
    private var bottomView: some View {
        VStack(spacing: .zero) {
            if viewModel.isAssistantListening {
                listeningView
            } else {
                readyToListenView
            }
        }
    }
    
    private var readyToListenView: some View {
        VStack(spacing: 12) {
            HStack(spacing: 8) {
                Circle()
                    .frame(width: 8, height: 8)
                    .foregroundStyle(Colors.dotColor)
                Text(viewModel.strings.ready)
                    .foregroundStyle(Colors.textColor)
            }
            Text(viewModel.strings.tapToBegin)
                .foregroundStyle(Colors.textColor.opacity(0.6))
        }
    }
    
    private var listeningView: some View {
        VStack(spacing: 12) {
            HStack(spacing: 8) {
                Circle()
                    .frame(width: 8, height: 8)
                    .foregroundStyle(Colors.externalCircleColor)
                    .blinking(duration: 1.0)
                Text(viewModel.strings.listening)
                    .foregroundStyle(Colors.textColor)
            }
            Text(viewModel.strings.speakNow)
                .foregroundStyle(Colors.textColor.opacity(0.6))
        }
    }
    
    private var microphoneButtonView: some View {
        Button{
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            viewModel.toggleListening(with : modelContext)
        } label: {
            microphoneView
        }
    }
    
    private var microphoneView: some View {
        ZStack {
            fetchCircle(Colors.externalCircleColor, size: 140)
            fetchCircle(Colors.internalCircleColor, size: 100)
            if viewModel.isAssistantListening {
                Image(systemName: ImageConstants.micFill.rawValue)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28)
                    .foregroundStyle(Colors.externalCircleColor)
            } else {
                Image(systemName: ImageConstants.micSlash.rawValue)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(Colors.textColor)
            }
        }
    }

    private func fetchCircle(_ color: Color,
                             size: CGFloat,
                             lineWidth: CGFloat = 3) -> some View {
        VStack {
            Circle()
                .fill(Color.clear)
                .frame(width: size,
                       height: size)
                .overlay(
                    Circle()
                        .stroke(color, lineWidth: lineWidth)
                )
                .background(Color.clear)
        }
    }

    private var viewHistory: some View {
        Button {
            viewModel.moveToJournalTimeline = true
        } label: {
            HStack(spacing: 12) {
                Image(systemName: ImageConstants.circlepath.rawValue)
                    .resizable()
                    .frame(width: 12, height: 12)
                    .symbolRenderingMode(.multicolor)
                    .foregroundStyle(Colors.textColor)
                Text(viewModel.strings.viewHistory)
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
    VoiceAssistantView(viewModel: VoiceAssistantViewModel())
}
