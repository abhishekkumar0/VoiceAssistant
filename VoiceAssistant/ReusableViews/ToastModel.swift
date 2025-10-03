//
//  ToastModel.swift
//  VoiceAssistant
//
//  Created by Abhishek on 03/10/25.
//
import SwiftUI

public enum ToastStyle {
    case error

    var background: Color {
        switch self {
        case .error:
            Colors.toastErrorColor
        }
    }

    var iconName: String? {
        switch self {
        case .error:
            return "xmark"
        }
    }
}
