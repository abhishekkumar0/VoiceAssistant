//
//  Toast.swift
//  VoiceAssistant
//
//  Created by Abhishek on 03/10/25.
//

import SwiftUI
import Combine

struct ToastModifier: ViewModifier {
    @Binding var isPresented: Bool
    let message: String
    let style: ToastStyle
    let duration: TimeInterval
    let alignment: Alignment
    let maxWidth: CGFloat?

    @State private var dismissWorkItem: DispatchWorkItem?

    func body(content: Content) -> some View {
        ZStack(alignment: alignment) {
            content

            if isPresented {
                toastContainer
                    .padding(.bottom, 80)
                    .padding(.horizontal, 16)
                    .transition(.move(edge: alignment == .bottom ? .bottom : .top).combined(with: .opacity))
                    .zIndex(1)
                    .onAppear(perform: scheduleAutoDismiss)
                    .onTapGesture(perform: dismiss)
                    .animation(.spring(response: 0.35, dampingFraction: 0.85), value: isPresented)
            }
        }
    }

    private var toastContainer: some View {
        ToastView(message: message, style: style, maxWidth: maxWidth ?? UIScreen.main.bounds.width - 60)
            .frame(maxWidth: maxWidth ?? .infinity)
    }

    private func scheduleAutoDismiss() {
        dismissWorkItem?.cancel()
        let workItem = DispatchWorkItem {
            withAnimation {
                isPresented = false
            }
        }
        dismissWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: workItem)
    }

    private func dismiss() {
        dismissWorkItem?.cancel()
        withAnimation {
            isPresented = false
        }
    }
}

public extension View {
    func toast(isPresented: Binding<Bool>,
               message: String,
               style: ToastStyle = .error,
               duration: TimeInterval = 2.5,
               alignment: Alignment = .bottom,
               maxWidth: CGFloat? = nil) -> some View {
        modifier(ToastModifier(isPresented: isPresented,
                               message: message,
                               style: style,
                               duration: duration,
                               alignment: alignment,
                               maxWidth: maxWidth))
    }
}
