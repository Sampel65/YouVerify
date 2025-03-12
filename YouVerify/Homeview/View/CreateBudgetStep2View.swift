import SwiftUI

struct CreateBudgetStep2View: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var currentStep: Int
    @Binding var budgetData: BudgetCreationData
    
    @Binding var selectedStartDate: Date?
    @Binding var selectedEndDate: Date?
    @Binding var selectedFundSource: FundSource?
    
    @State private var showingDatePicker = false
    
    let fundSources = [
        FundSource(name: "Kuda Bank", balance: "2,987.56", icon: "kuda")
    ]
    
    private func formatDateRange() -> String {
        if let start = selectedStartDate, let end = selectedEndDate {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            return "\(formatter.string(from: start)) - \(formatter.string(from: end))"
        }
        return "Pick a start and end date"
    }
    
    var body: some View {
        VStack(spacing: 24) {
            // Header
            HStack {
                Button(action: { currentStep -= 1 }) {
                    Image("back2")
                        .foregroundColor(Color("buttoncolor"))
                        .imageScale(.large)
                }
                
                Spacer()
                
                FinTrackText("2 of 3",
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
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading, spacing: 12) {
                        FinTrackText("Name of budget",
                                  size: 16,
                                  weight: .bold)
                        
                        TextField("", text: .constant(budgetData.name))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disabled(true)
                    }
                    
                    // Budget amount
                    VStack(alignment: .leading, spacing: 12) {
                        FinTrackText("Set a budget amount",
                                  size: 16,
                                  weight: .bold)
                        
                        TextField("₦ 200,000", value: $budgetData.amount, formatter: NumberFormatter())
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                    }
                    
                    // Cycle of budget
                    VStack(alignment: .leading, spacing: 12) {
                        FinTrackText("Cycle of budget",
                                  size: 16,
                                  weight: .bold)
                        
                        Button(action: { showingDatePicker = true }) {
                            HStack {
                                Text(formatDateRange())
                                    .font(.custom("Capriola-Regular", size: 16))
                                    .foregroundColor(selectedStartDate == nil ? .gray : .black)
                                Spacer()
                                Image(systemName: "calendar")
                                    .foregroundColor(Color("buttoncolor"))
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                        }
                    }
                    
                    // Budget source
                    VStack(alignment: .leading, spacing: 16) {
                        FinTrackText("Budget source",
                                  size: 16,
                                  weight: .bold)
                        
                        Menu {
                            ForEach(fundSources, id: \.name) { source in
                                Button(source.name) {
                                    selectedFundSource = source
                                }
                            }
                        } label: {
                            HStack {
                                FinTrackText(selectedFundSource?.name ?? "Select account(s)",
                                          size: 16,
                                          color: selectedFundSource == nil ? .gray : .black)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.black)
                            }
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                            .background(Color.white)
                            .cornerRadius(12)
                        }
                        
                        if let source = selectedFundSource {
                            HStack(spacing: 12) {
                                Image(source.icon)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 48, height: 48)
                                    .cornerRadius(8)
                                    .background(Color.purple)
                                
                                VStack(alignment: .leading) {
                                    FinTrackText(source.name,
                                              size: 16)
                                    FinTrackText("Account balance: ₦\(source.balance)",
                                              size: 14,
                                              color: .gray)
                                }
                            }
                            .padding(12)
                            .background(Color.white)
                            .cornerRadius(12)
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            Spacer()
            
            Button(action: {
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
            .disabled(budgetData.amount <= 0 || selectedStartDate == nil || selectedEndDate == nil || selectedFundSource == nil)
            .opacity(budgetData.amount <= 0 || selectedStartDate == nil || selectedEndDate == nil || selectedFundSource == nil ? 0.6 : 1)
            .padding(.bottom)
        }
        .background(Color("backgroundColor").ignoresSafeArea())
        .sheet(isPresented: $showingDatePicker) {
            CustomCalendarView(startDate: $selectedStartDate,
                             endDate: $selectedEndDate)
        }
    }
}
