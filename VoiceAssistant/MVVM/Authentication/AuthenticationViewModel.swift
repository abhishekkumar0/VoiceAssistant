//
//  AuthenticationViewModel.swift
//  VoiceAssistant
//
//  Created by Abhishek on 03/10/25.
//

import SwiftUI
import Combine

final class AuthenticationViewModel: ObservableObject {
    let strings = Strings()
    @Published var goToVoiceAssistent: Bool = false
    @Published var showToast: Bool = false
    
    func isValid(_ details: UserDetails) -> Bool {
        if details.firstName.isEmpty {
            return false
        }
        if details.lastName.isEmpty {
            return false
        }
        if details.emailId.isEmpty {
            return false
        }
        return true
    }
}

extension AuthenticationViewModel {
    struct Strings {
        let title: String = "Welcome"
        let nameTitle: String = "First Name"
        let nameTFPlaceholder: String = "Enter you first name..."
        let lastNameTitle: String = "Last Name"
        let lastTFPlaceholder: String = "Enter you last name..."
        let emailTitle: String = "Email"
        let emailTFPlaceholder: String = "Enter you email address..."
        let buttonTitle: String = "Continue"
        let errorMessage: String = "Please enter your details..."
    }
}
