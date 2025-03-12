//
//  SignInViewModel.swift
//  YouVerify
//
//  Created by Samson Oluwapelumi on 10/03/2025.
//


import SwiftUI
import FirebaseAuth

class SignInViewModel: ObservableObject {
    @Published var email = ""
    @Published var isLoading = false
    @Published var errorMessage = ""
    @Published var navigateToHome = false
    
    func signIn() {
        isLoading = true
        
        guard !email.isEmpty else {
            errorMessage = "Please enter your email"
            isLoading = false
            return
        }
        
        // Here you would typically implement your sign-in logic
        // For now, we'll just simulate success
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isLoading = false
            self.navigateToHome = true
        }
    }
}