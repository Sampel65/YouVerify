import Foundation
import FirebaseAuth

class SignupViewModel: ObservableObject {
    @Published var fullName = ""
    @Published var email = ""
    @Published var referralCode = ""
    @Published var isLoading = false
    @Published var errorMessage = ""
    
    func createAccount(completion: @escaping (Bool) -> Void) {
        isLoading = true
        
        guard !fullName.isEmpty else {
            errorMessage = "Please enter your name"
            isLoading = false
            completion(false)
            return
        }
        
        guard !email.isEmpty else {
            errorMessage = "Please enter your email"
            isLoading = false
            completion(false)
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: "temporary-password") { result, error in
            DispatchQueue.main.async {
                self.isLoading = false
                
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    completion(false)
                    return
                }
                completion(true)
            }
        }
    }
}
