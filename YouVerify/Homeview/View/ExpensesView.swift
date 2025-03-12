import SwiftUI

struct ExpensesView: View {
    @State private var showingOptions = false
    @State private var showingTransactions = false
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 16) {
                    // Header
             
                    HStack {
                        Spacer()
                        Text("My Expenses")
                            .font(.capriolaRegular(size: 15))
                        
                        Spacer()
                        
                        Button(action: { showingOptions = true }) {
                            Image("more")
                                .resizable()
                                .frame(width: 24, height: 24)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Total Expenses Card
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Total expenses")
                            .font(.capriolaRegular(size: 14))
                        
                        HStack {
                            Text("₦ 1,000,500.55")
                                .font(.capriolaRegular(size: 24))
                                .bold()
                            
                            Button(action: {}) {
                                Image("eye")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                            }
                        }
                        
                        Text("spent in the last 7 days")
                            .font(.capriolaRegular(size: 12))
                            .foregroundColor(.black.opacity(0.6))
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.orange.opacity(0.2))
                    .cornerRadius(16)
                    .padding(.horizontal)
                    
                    // Sort Button
                    Button(action: {}) {
                        HStack {
                            Text("Sort your expenses")
                                .font(.capriolaRegular(size: 16))
                                .foregroundColor(.black)
                            Spacer()
                            Image("chevron")
                                .resizable()
                                .frame(width: 24, height: 24)
                        }
                        .padding(16)
                        .background(Color.white)
                        .cornerRadius(12)
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.1), lineWidth: 1)
                        }
                    }
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Transactions")
                                .font(.capriolaRegular(size: 16))
                            Spacer()
                            Button(action: { showingTransactions = true }) {
                                Text("View All")
                                    .font(.capriolaRegular(size: 14))
                                    .foregroundColor(Color("buttoncolor"))
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(Color("buttoncolor").opacity(0.1))
                                    .cornerRadius(16)
                            }
                        }
                        
                        TransactionList()
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
                .padding(.top)
                .background(Color("backgroundColor"))
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: { showingAddExpense = true }) {
                            Circle()
                                .fill(Color("orangeButton"))
                                .frame(width: 56, height: 56)
                                .overlay {
                                    Image(systemName: "plus")
                                        .font(.system(size: 24, weight: .medium))
                                        .foregroundColor(.white)
                                }
                                .shadow(color: Color("buttoncolor").opacity(0.3), radius: 10, y: 5)
                        }
                        .padding(.trailing, 24)
                        .padding(.bottom, 10)
                    }
                }
            }
            .navigationDestination(isPresented: $showingTransactions) {
                TransactionsView().navigationBarBackButtonHidden(true)
            }
        }
    }
}

// Helper Views
struct TransactionList: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Today, 14/07/2024")
                .font(.capriolaRegular(size: 14))
                .foregroundColor(.gray)
            

                TransactionRow(
                    icon: "food",
                    title: "Food & Drinks",
                    amount: "₦200,000.00"
                )
           
            
            ForEach(0..<2) { _ in
                TransactionRow(
                    icon: "Transportation",
                    title: "Transportation",
                    amount: "₦50,000.00"
                )
            }
            
            Text("Yesterday, 13/07/2024")
                .font(.capriolaRegular(size: 14))
                .foregroundColor(.gray)
            
            TransactionRow(
                icon: "food",
                title: "Food & Drinks",
                amount: "₦200,000.00"
            )
        }
    }
}

struct TransactionRow: View {
    let icon: String
    let title: String
    let amount: String
    
    var body: some View {
        HStack(spacing: 12) {
            // Update icon with circular background
            Circle()
                .fill(Color("buttoncolor").opacity(0.1))
                .frame(width: 36, height: 36)
                .overlay {
                    Image(icon)
                        .resizable()
                        .frame(width: 20, height: 20)
                }
            
            Text(title)
                .font(.capriolaRegular(size: 16))
            
            Spacer()
            
            Text(amount)
                .font(.capriolaRegular(size: 16))
                .bold()
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(12)
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.1), lineWidth: 1)
        }
    }
}
