import SwiftUI

struct TransactionsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""
    
    var body: some View {
        VStack(spacing: 16) {
            // Header
            HStack {
                Button(action: { dismiss() }) {

                            Image("back")
                                .resizable()
                                .frame(width: 30, height: 30)
 
                }
                
                Spacer()
                
                Text("Transactions")
                    .font(.capriolaRegular(size: 15))
                
                Spacer()
                
                Button(action: {}) {
                            Image("filter")
                                .resizable()
                                .frame(width: 24, height: 24)
                   
                }
            }
            .padding(.horizontal)
            
            // Search Bar
            SearchTextField(text: $searchText, placeholder: "Search")
                .padding(.horizontal)

            ScrollView {
                LazyVStack(alignment: .leading, spacing: 16) {
                    ForEach(0..<4) { section in
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Today, 14/07/2024")
                                .font(.capriolaRegular(size: 14))
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                            
                            TransactionRow(
                                icon: "food",
                                title: "Food and drink",
                                amount: "₦200,000"
                            )
                            .padding(.horizontal)
                            
                            ForEach(0..<2) { _ in
                                TransactionRow(
                                    icon: "Transportation",
                                    title: "Transportation",
                                    amount: "₦50,000.00"
                                )
                                .padding(.horizontal)
                            }
                        }
                    }
                }
            }
        }
        .padding(.top)
        .background(Color("backgroundColor").ignoresSafeArea())
    }
}
