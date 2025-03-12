//
//  VerificationViewModel.swift
//  YouVerify
//
//  Created by Samson Oluwapelumi on 10/03/2025.
//

import SwiftUI
import Combine

class VerificationViewModel: ObservableObject {
    @Published var verificationCode = ""
    @Published var isLoading = false
    @Published var errorMessage = ""
    @Published var navigateToHome = false
    
    func verifyCode() {
        isLoading = true
        
        guard !verificationCode.isEmpty else {
            errorMessage = "Please enter the verification code"
            isLoading = false
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isLoading = false
            self.navigateToHome = true
        }
    }
}

// End of file
