//
//  ToastView.swift
//  VoiceAssistant
//
//  Created by Abhishek on 03/10/25.
//

import SwiftUI
import Combine

struct ToastView: View {
    let message: String
    let style: ToastStyle
    let maxWidth: CGFloat

    var body: some View {
        HStack(spacing: 12) {
            if let icon = style.iconName {
                Image(systemName: icon)
                    .font(.system(size: 14, weight: .semibold))
                    .frame(width: 20, height: 20)
                    .foregroundColor(.white)
            }
            Text(message)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .lineLimit(3)
            Spacer(minLength: 0)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 14)
        .frame(maxWidth: maxWidth)
        .background(style.background)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.25), radius: 8, x: 0, y: 4)
    }
}
