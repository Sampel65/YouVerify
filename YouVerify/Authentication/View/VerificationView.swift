//
//  VerificationView.swift
//  YouVerify
//
//  Created by Samson Oluwapelumi on 10/03/2025.
//


import SwiftUI

struct VerificationView: View {
    @Binding var email: String
    @StateObject private var viewModel = VerificationViewModel()
    @State private var timeRemaining = 50
    @State private var isResendEnabled = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            FinTrackText("Check your email!",
                       size: 24,
                       weight: .bold)
            
            FinTrackText("We have sent an email to \(email). Please remember to check your inbox as well as the spam folder.",
                       size: 16,
                       color: .secondary)
            
            FinTrackText("Please enter the verification code below to continue with your account.",
                       size: 16,
                       color: .secondary)
                .padding(.top, 8)
            
            CustomTextField(
                title: "Enter verification code",
                placeholder: "e.g 1111",
                text: $viewModel.verificationCode
            )
                .keyboardType(.numberPad)
            
            Spacer()
            
            Button(action: {
                viewModel.verifyCode()
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 28)
                        .fill(Color("buttoncolor"))
                        .frame(height: 56)
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    } else {
                        FinTrackText("Continue",
                                  size: 16,
                                  color: .white)
                    }
                }
            }
            .disabled(viewModel.isLoading)
            
            HStack {
                FinTrackText("Didn't receive the email?",
                           size: 14,
                           color: .secondary)
                
                Button(action: {
                    if isResendEnabled {
                        timeRemaining = 50
                        isResendEnabled = false
                    }
                }) {
                    FinTrackText(isResendEnabled ? "Resend code" : "Resend code in \(timeRemaining)s",
                              size: 14,
                              color: isResendEnabled ? Color("buttoncolor") : .gray)
                }
                .disabled(!isResendEnabled)
            }
        }
        .padding()
        .onReceive(timer) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                isResendEnabled = true
            }
        }
        .alert(isPresented: Binding(get: { !viewModel.errorMessage.isEmpty },
                                  set: { _ in viewModel.errorMessage = "" })) {
            Alert(title: Text("Error"),
                  message: Text(viewModel.errorMessage),
                  dismissButton: .default(Text("OK")))
        }
        
        NavigationLink(destination: MainTabView()
            .navigationBarBackButtonHidden(true),
            isActive: $viewModel.navigateToHome
        ) {
            EmptyView()
        }
        .hidden()
        .navigationBarBackButtonHidden(true)
    }
}

struct VerificationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            VerificationView(email: .constant("test@example.com"))
        }
    }
}
