//
//  UserDetails.swift
//  VoiceAssistant
//
//  Created by Abhishek on 03/10/25.
//

import Foundation
import SwiftUI
import Combine

final class UserDetails: ObservableObject {
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var emailId: String = ""
}
