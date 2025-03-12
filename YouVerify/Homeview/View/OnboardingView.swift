//
//  OnboardingView.swift
//  YouVerify
//
//  Created by Samson Oluwapelumi on 10/03/2025.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject private var viewModel = OnboardingViewModel()
    @State private var shouldNavigateToSignup = false
    @State private var shouldNavigateToSignIn = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Progress bars
                HStack(spacing: 4) {
                    ForEach(0..<viewModel.onboardingPages.count, id: \.self) { index in
                        Rectangle()
                            .frame(height: 4)
                            .foregroundColor(viewModel.currentPage == index ? Color("buttoncolor") : Color.gray.opacity(0.3))
                    }
                }
                .padding(.top, 20)
                .padding(.horizontal, 24)
                
                TabView(selection: $viewModel.currentPage) {
                    ForEach(0..<viewModel.onboardingPages.count, id: \.self) { index in
                        OnboardingPageView(page: viewModel.onboardingPages[index])
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                VStack(spacing: 16) {
                    CustomButton(title: "Create an account", action: viewModel.handleCreateAccount)
                    
                    HStack(spacing: 4) {
                        Text("Already have an account?")
                            .font(.capriolaRegular(size: 14))
                            .foregroundColor(Color(.label))
                        
                        Button(action: { shouldNavigateToSignIn = true }) {
                            Text("Sign in")
                                .font(.capriolaRegular(size: 14))
                                .foregroundColor(Color("buttoncolor"))
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 48)
            }
            .background(Color(.systemBackground))
            .sheet(isPresented: $viewModel.showingCreateAccount) {
                CreateAccountSheet(isPresented: $viewModel.showingCreateAccount, shouldNavigateToSignup: $shouldNavigateToSignup)
                    .presentationDetents([.height(280)])
                    .presentationDragIndicator(.hidden)
                    .presentationBackground(.white)
            }
            .overlay {
                if viewModel.showingCreateAccount {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                        .allowsHitTesting(false)
                }
            }
            .navigationDestination(isPresented: $shouldNavigateToSignup) {
                SignupView().navigationBarBackButtonHidden(true)
            }
            .navigationDestination(isPresented: $shouldNavigateToSignIn) {
                SignInView().navigationBarBackButtonHidden(true)
            }
        }
    }
}

struct CreateAccountSheet: View {
    @Binding var isPresented: Bool
    @Binding var shouldNavigateToSignup: Bool
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                HStack {
                    
                    Text("Create an account")
                        .font(.capriolaRegular(size: 20))
                        .fontWeight(.medium)
                        .foregroundColor(Color(.label))
                    
                    Spacer()
                    Button(action: { isPresented = false }) {
                        Image("cancel")
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .medium))
                    }
                    .padding(.trailing, 24)
                    .padding(.top, 24)
                }

                
                Text("By pressing accept below you agree to our ")
                    .font(.capriolaRegular(size: 14))
                    .foregroundColor(Color(.label)) +
                Text("Terms and Conditions")
                    .font(.capriolaRegular(size: 14))
                    .foregroundColor(Color(.label))
                    .underline() +
                Text(". You can find out more about how we use your data in our ")
                    .font(.capriolaRegular(size: 14))
                    .foregroundColor(Color(.label)) +
                Text("Privacy Policy")
                    .font(.capriolaRegular(size: 14))
                    .foregroundColor(Color(.label))
                    .underline()
                
                Button(action: {
                    isPresented = false
                    shouldNavigateToSignup = true
                }) {
                    Text("Accept and Continue")
                        .font(.capriolaRegular(size: 16))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("buttoncolor"))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal, 24)
                .padding(.top, 8)
                
                Spacer()
            }
            .multilineTextAlignment(.leading)
            .padding(.horizontal, 24)
        }
    }
}

#Preview {
    OnboardingView()
}
