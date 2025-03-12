import SwiftUI

struct CreateBudgetStep1View: View {
    @Environment(\.dismiss) private var dismiss
    @State private var budgetName = ""
    @Binding var currentStep: Int
    @Binding var budgetData: BudgetCreationData
    
    var body: some View {
        VStack(spacing: 24) {
            // Header
            HStack {
                Button(action: { dismiss() }) {
                    Image("back2")
                        .foregroundColor(Color("buttoncolor"))
                        .imageScale(.large)
                }
                
                Spacer()
                
                FinTrackText("1 of 3",
                          size: 16,
                          weight: .regular)
                
                Spacer()
            }
            .padding(.horizontal)
            
            VStack(spacing: 16) {
                FinTrackText("Create your budget",
                          size: 24,
                          weight: .bold)
                
                FinTrackText("Setup a spending budget whether it's for a month, a week or even a trip.",
                          size: 16,
                          color: .gray,
                          textAlignment: .center)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            
            VStack(alignment: .leading, spacing: 12) {
                FinTrackText("Name of budget",
                          size: 16,
                          weight: .bold)
                
                TextField("Enter the name of your budget here", text: $budgetName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.custom("Capriola-Regular", size: 16))
            }
            .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 16) {
                FinTrackText("Quick picks",
                          size: 16,
                          weight: .bold)
                
                HStack(spacing: 16) {
                    Button(action: { budgetName = "Monthly Budget" }) {
                        Text("Monthly Budget")
                            .font(.custom("Capriola-Regular", size: 14))
                            .foregroundColor(.black)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(20)
                    }
                    
                    Button(action: { budgetName = "Weekly Budget" }) {
                        Text("Weekly Budget")
                            .font(.custom("Capriola-Regular", size: 14))
                            .foregroundColor(.black)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(20)
                    }
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            Button(action: {
                budgetData.name = budgetName
                currentStep += 1
            }) {
                Text("Next")
                    .font(.custom("Capriola-Regular", size: 16))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(Color("buttoncolor"))
                    .cornerRadius(28)
                    .padding(.horizontal)
            }
            .disabled(budgetName.isEmpty)
            .opacity(budgetName.isEmpty ? 0.6 : 1)
            .padding(.bottom)
        }
        .background(Color("backgroundColor").ignoresSafeArea())
    }
}

struct BudgetCreationData {
    var name: String = ""
    var amount: Double = 0.0
    var period: String = ""
}

