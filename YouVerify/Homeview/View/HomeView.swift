import SwiftUI

struct HomeView: View {
    @State private var selectedTab = 0
    @State private var currentCardIndex = 0
    private let cards = [
        ("Account balance", "₦0.00", "The total balance from your linked bank accounts.", "Link bank accounts", Color("buttoncolor"), FinanceCardImageType.wallet),
        ("Total Savings", "₦0.00", "You haven't created any savings goals yet", "Add a savings goal", Color.orange.opacity(0.8), FinanceCardImageType.piggyBank),
        ("Monthly budget", "₦0.00", "You haven't created any budgets yet", "Create a Budget", Color("buttoncolor"), FinanceCardImageType.target),
        ("Total expenses", "₦0.00", "You haven't linked any bank account yet", "Link bank accounts", Color.orange.opacity(0.3), FinanceCardImageType.expenses)
    ]
    
    var body: some View {
        VStack(spacing: 16) {
            // Header
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Hello, Jane")
                        .font(.capriolaRegular(size: 24))
                        .bold()
                    
                    Text("Your financial journey starts here.")
                        .font(.capriolaRegular(size: 14))
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                HStack(spacing: 16) {
                    Button(action: {}) {
                        Image("person")
                    }
                    
                    Button(action: {}) {
                        Image("Bell")
   
                    }
                }
            }
            .padding(.horizontal)
            
            // Horizontal scroll cards with PageTabViewStyle
            TabView(selection: $currentCardIndex) {
                ForEach(0..<cards.count, id: \.self) { index in
                    FinanceCard(
                        title: cards[index].0,
                        amount: cards[index].1,
                        description: cards[index].2,
                        actionText: cards[index].3,
                        backgroundColor: cards[index].4,
                        imageType: cards[index].5
                    )
                    .tag(index)
                    .padding(.horizontal, 8)
                }
            }
            .frame(height: 180)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            // Custom indicator
            HStack(spacing: 4) {
                ForEach(0..<cards.count, id: \.self) { index in
                    Capsule()
                        .fill(currentCardIndex == index ? Color("buttoncolor") : Color.gray.opacity(0.15))
                        .frame(width: currentCardIndex == index ? 16 : 4, height: 4)
                        .animation(.easeInOut, value: currentCardIndex)
                }
            }
            

            VStack(spacing: 16) {
                Text("You have no activities yet")
                    .font(.capriolaRegular(size: 16))
                    .bold()
                
                Text("Hi there, you have no linked\nbank accounts.")
                    .font(.capriolaRegular(size: 10))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
                Button(action: {}) {
                    Text("Link account")
                        .font(.capriolaRegular(size: 14))
                        .foregroundColor(Color("buttoncolor"))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color("buttoncolor").opacity(0.1))
                        .cornerRadius(16)
                }
                
                Image("empty_state")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 98)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)
            .padding(.horizontal, 8)
            
            Spacer()
            

        }
        .padding(.top)
        .background(Color.white)
    }
}
