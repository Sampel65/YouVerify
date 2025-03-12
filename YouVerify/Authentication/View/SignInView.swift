//
//  SignInView.swift
//  YouVerify
//
//  Created by Samson Oluwapelumi on 10/03/2025.
//
import SwiftUI


struct SignInView: View {
    @StateObject private var viewModel = SignInViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Welcome back ")
                .font(.capriolaRegular(size: 24))
                .bold()
            
            Text("Sign in to your account and start managing your finances with Fintrack today.")
                .font(.capriolaRegular(size: 16))
                .foregroundColor(.secondary)
            
            CustomTextField(
                title: "Email address",
                placeholder: "e.g email@mail.com",
                text: $viewModel.email,
                keyboardType: .emailAddress,
                autocapitalization: .never
            )
            
            Spacer()
            
            VStack(spacing: 16) {
                NavigationLink(destination: VerificationView(email: $viewModel.email)
                    .navigationBarBackButtonHidden(true),
                    isActive: $viewModel.navigateToHome
                ) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 28)
                            .fill(Color("buttoncolor"))
                            .frame(height: 56)
                        
                        if viewModel.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        } else {
                            Text("Sign In")
                                .font(.capriolaRegular(size: 16))
                                .foregroundColor(.white)
                        }
                    }
                }
                .disabled(viewModel.isLoading)
                
                HStack(spacing: 4) {
                    Text("Do not have an account?")
                        .font(.capriolaRegular(size: 14))
                    
                    NavigationLink(destination: SignupView().navigationBarBackButtonHidden(true)) {
                        Text("Sign Up")
                            .font(.capriolaRegular(size: 14))
                            .foregroundColor(Color("buttoncolor"))
                    }
                }
            }
        }
        .padding()
        .alert(isPresented: Binding(get: { !viewModel.errorMessage.isEmpty },
                                  set: { _ in viewModel.errorMessage = "" })) {
            Alert(title: Text("Error").font(.capriolaRegular(size: 16)),
                  message: Text(viewModel.errorMessage).font(.capriolaRegular(size: 14)),
                  dismissButton: .default(Text("OK").font(.capriolaRegular(size: 14))))
        }

    }
}

#Preview {
    NavigationStack {
        SignInView()
    }
}
