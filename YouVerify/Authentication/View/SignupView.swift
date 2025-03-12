import SwiftUI

struct SignupView: View {
    @StateObject private var viewModel = SignupViewModel()
    @State private var isNavigatingToVerification = false
    @State private var isNavigatingToSignIn = false
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20) {
            FinTrackText("Let's get started! ",
                      size: 24,
                      weight: .bold,
                      textAlignment: .leading)
                .font(.capriolaRegular(size: 24))
                .bold()
            
            FinTrackText("Join us and start managing your finances with Fintrack today.",
                      size: 16,
                      textAlignment: .leading)
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
                NavigationLink(destination: VerificationView(email: $viewModel.email).navigationBarBackButtonHidden(true),
                             isActive: $isNavigatingToVerification) { EmptyView() }
                
                Button(action: {
                    viewModel.createAccount { success in
                        if success {
                            isNavigatingToVerification = true
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
                            FinTrackText("Create an account",
                                      size: 16,
                                      weight: .bold)
                                .foregroundColor(.white)
                        }
                    }
                }
                .disabled(viewModel.isLoading)
                
                HStack(spacing: 4) {
                    FinTrackText("Already have an account?",
                              size: 14)
                    
                    NavigationLink(destination: SignInView().navigationBarBackButtonHidden(true)) {
                        FinTrackText("Sign In",
                                  size: 14)
                            .foregroundColor(Color(red: 0.22, green: 0.49, blue: 0.49))
                    }
                }
                .font(.subheadline)
            }
        }
        .padding()
        .alert(isPresented: Binding(get: { !viewModel.errorMessage.isEmpty },
                                  set: { _ in viewModel.errorMessage = "" })) {
            Alert(title: Text("Error"),
                  message: Text(viewModel.errorMessage),
                  dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    NavigationView {
        SignupView()
    }
}
