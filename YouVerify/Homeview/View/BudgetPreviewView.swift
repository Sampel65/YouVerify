import SwiftUI

struct BudgetPreviewView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var receiveAlert = false
    
    let budgetData: BudgetCreationData
    let selectedStartDate: Date?
    let selectedEndDate: Date?
    let selectedFundSource: FundSource?
    
    var body: some View {
        VStack(spacing: 20) {
            // Header
            HStack {
                Button(action: { dismiss() }) {
                            Image("back2")
                                .resizable()
                                .frame(width: 30, height: 30)

                }
                
                Spacer()
                
                FinTrackText("Budget preview",
                      size: 16,
                      weight: .medium)
                
                Spacer()
            }
            .padding(.horizontal)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    // Budget Info Card with target icon
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            FinTrackText(budgetData.name,
                                      size: 13,
                                      weight: .medium)
                            
                            Spacer()
                            
                            Button(action: {}) {
                                FinTrackText("Set as Default",
                                          size: 10,
                                          color: .white)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color("buttoncolor"))
                                    .cornerRadius(20)
                            }
                        }
                        
                        FinTrackText("Budget cycle: \(selectedStartDate?.formatted(date: .numeric, time: .omitted) ?? "") to \(selectedEndDate?.formatted(date: .numeric, time: .omitted) ?? "")",
                                  size: 12,
                                  color: .gray)
                        
                        FinTrackText("₦ \(String(format: "%.2f", budgetData.amount))",
                                  size: 28,
                                  weight: .bold)
                        
                        ZStack(alignment: .bottomTrailing) {
                            Color.clear
                            Image("target")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    
                    // Budget Source Section
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            FinTrackText("Budget source",
                                      size: 12,
                                      weight: .medium)
                            
                            Spacer()
                            
                            Button(action: {}) {
                                HStack(spacing: 4) {
                                    FinTrackText("Change",
                                              size: 10,
                                              color: Color("buttoncolor"))
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(Color("buttoncolor"))
                                        .font(.subheadline)
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color("buttoncolor").opacity(0.1))
                                .cornerRadius(20)
                            }
                        }
                        
                        ForEach(0..<2) { _ in
                            if let source = selectedFundSource {
                                HStack(spacing: 12) {
                                    Image(source.icon)
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        FinTrackText(source.name,
                                                  size: 12,
                                                  weight: .medium)
                                        FinTrackText("Account balance: ₦\(source.balance)",
                                                  size: 12,
                                                  color: .gray)
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    
                    // Budget Cycle Section
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            FinTrackText("Budget cycle",
                                      size: 12,
                                      weight: .medium)
                            
                            Spacer()
                            
                            Button(action: {}) {
                                HStack(spacing: 4) {
                                    FinTrackText("Change",
                                              size: 12,
                                              color: Color("buttoncolor"))
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(Color("buttoncolor"))
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color("buttoncolor").opacity(0.1))
                                .cornerRadius(20)
                            }
                        }
                        
                        HStack(spacing: 40) {
                            if let start = selectedStartDate {
                                VStack(alignment: .leading, spacing: 8) {
                                    Image(systemName: "calendar")
                                        .foregroundColor(.black)
                                    FinTrackText(start.formatted(date: .numeric, time: .omitted),
                                              size: 12,
                                              weight: .medium)
                                    FinTrackText("Start date",
                                              size: 12,
                                              color: .gray)
                                }
                            }
                            
                            if let end = selectedEndDate {
                                VStack(alignment: .leading, spacing: 8) {
                                    Image(systemName: "calendar")
                                        .foregroundColor(.black)
                                    FinTrackText(end.formatted(date: .numeric, time: .omitted),
                                              size: 12,
                                              weight: .medium)
                                    FinTrackText("End date",
                                              size: 12,
                                              color: .gray)
                                }
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    
                    // Alert Toggle Section
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            FinTrackText("Receive alert when it reaches a certain limit",
                                      size: 12,
                                      color: .gray)
                            
                            Spacer()
                            
                            Toggle("", isOn: $receiveAlert)
                                .tint(Color("buttoncolor"))
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                }
                .padding(.horizontal)
            }
            
            // Create Budget Button
            Button(action: {}) {
                FinTrackText("Create Budget",
                          size: 14,
                          weight: .medium,
                          color: .white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color("buttoncolor"))
                    .cornerRadius(28)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .background(Color("backgroundColor").ignoresSafeArea())
    }
}

#Preview {
    BudgetPreviewView(
        budgetData: BudgetCreationData(name: "Trip to Nairobi", amount: 200000.0),
        selectedStartDate: Date(),
        selectedEndDate: Date().addingTimeInterval(86400 * 30),
        selectedFundSource: FundSource(name: "Kuda Bank", balance: "2,987.56", icon: "kuda")
    )
}
