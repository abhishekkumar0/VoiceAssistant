//
//  AuthenticationView.swift
//  VoiceAssistant
//
//  Created by Abhishek on 03/10/25.
//

import SwiftUI

private enum InputTextType: CaseIterable, Identifiable {
    var id: Self { self }

    case firstName
    case lastName
    case emailId
}

struct AuthenticationView: View {
    @ObservedObject var viewModel: AuthenticationViewModel
    @StateObject var details = UserDetails()

    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    contentView
                }
                actionButton
            }
            .onTapGesture {
                hideKeyboard()
            }
            .toast(isPresented: $viewModel.showToast,
                   message: viewModel.strings.errorMessage)
            .padding(.top, 50)
            .navigationTitle(viewModel.strings.title)
            .navigationDestination(isPresented: $viewModel.goToVoiceAssistent) {
                VoiceAssistantView(viewModel: VoiceAssistantViewModel())
            }
        }
        .preferredColorScheme(.dark)
        .environmentObject(details)
    }

    private var actionButton: some View {
        Button {
            if viewModel.isValid(details) {
                viewModel.goToVoiceAssistent = true
            } else {
                viewModel.showToast = true
            }
        } label: {
            HStack(spacing: 12) {
                Text(viewModel.strings.buttonTitle)
                    .symbolRenderingMode(.multicolor)
                    .foregroundStyle(.white)
                    .font(.system(size: 15))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 0)
                    .stroke(Colors.textColor, lineWidth: 2)
            )
            .padding(.horizontal, 30)
        }
    }

    private var contentView: some View {
        VStack(spacing: 20) {
            ForEach(InputTextType.allCases) { type in
                inputView(type)
            }
        }
    }
    
    @ViewBuilder
    private func inputView(_ type: InputTextType) -> some View {
        switch type {
        case .firstName:
            userInputView(viewModel.strings.nameTitle,
                          viewModel.strings.nameTFPlaceholder,
                          $details.firstName)
        case .lastName:
            userInputView(viewModel.strings.lastNameTitle,
                          viewModel.strings.lastTFPlaceholder,
                          $details.lastName)
        case .emailId:
            userInputView(viewModel.strings.emailTitle,
                          viewModel.strings.emailTFPlaceholder,
                          $details.emailId)
        }
    }
    
    private func userInputView(_ title: String,
                               _ placeholder: String,
                               _ text: Binding<String>) -> some View {
        VStack(alignment: .leading,
               spacing: 10) {
            Text(title)
            TextField(placeholder, text: text)
                .frame(height: 48)
                .padding(EdgeInsets(top: 0,
                                    leading: 12,
                                    bottom: 0,
                                    trailing: 12))
                .cornerRadius(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(lineWidth: 1.0)
                )
        }
               .padding(.horizontal, 24)
    }
}

#Preview {
    AuthenticationView(viewModel: AuthenticationViewModel())
}
