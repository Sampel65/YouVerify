import SwiftUI

struct SignupView: View {
    @StateObject private var viewModel = SignupViewModel()
    @State private var navigateToVerification = false
    @State private var navigateToSignIn = false
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20) {
            Text("Let's get started! ")
                .font(.capriolaRegular(size: 24))
                .bold()
            
            Text("Join us and start managing your finances with Fintrack today.")
                .font(.capriolaRegular(size: 16))
                .foregroundColor(.secondary)
            
            CustomTextField(
                title: "First & Last Name",
                placeholder: "e.g John Doe",
                text: $viewModel.fullName
            )
            
            CustomTextField(
                title: "Email address",
                placeholder: "e.g email@mail.com",
                text: $viewModel.email,
                keyboardType: .emailAddress,
                autocapitalization: .never
            )
            
            CustomTextField(
                title: "Enter a referral code(optional)",
                placeholder: "e.g email@mail.com",
                text: $viewModel.referralCode
            )
            
            Spacer()
            
            VStack(spacing: 16) {
                Button(action: {
                    viewModel.createAccount { success in
                        if success {
                            navigateToVerification = true
                        }
                    }
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color(red: 0.22, green: 0.49, blue: 0.49))
                            .frame(height: 50)
                        
                        if viewModel.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        } else {
                            Text("Create an account")
                                .font(.capriolaRegular(size: 16))
                                .foregroundColor(.white)
                                .bold()
                        }
                    }
                }
                .disabled(viewModel.isLoading)
                
                HStack(spacing: 4) {
                    Text("Already have an account?")
                        .font(.capriolaRegular(size: 14))
                    
                    Button(action: { navigateToSignIn = true }) {
                        Text("Sign In")
                            .font(.capriolaRegular(size: 14))
                            .foregroundColor(Color(red: 0.22, green: 0.49, blue: 0.49))
                    }
                }
                .font(.subheadline)
            }
        }
        .padding()
        .alert(isPresented: Binding(get: { !viewModel.errorMessage.isEmpty },
                                  set: { _ in viewModel.errorMessage = "" })) {
            Alert(title: Text("Error").font(.capriolaRegular(size: 16)),
                  message: Text(viewModel.errorMessage).font(.capriolaRegular(size: 14)),
                  dismissButton: .default(Text("OK").font(.capriolaRegular(size: 14))))
        }
        .navigationDestination(isPresented: $navigateToVerification) {
            VerificationView(email: viewModel.email)
        }
        .navigationDestination(isPresented: $navigateToSignIn) {
            SignInView()
        }
    }
}

#Preview {
    NavigationView {
        SignupView()
    }
}
