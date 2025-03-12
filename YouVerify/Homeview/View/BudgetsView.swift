import SwiftUI

struct BudgetsView: View {
    @State private var isNavigating = false
    
    var body: some View {
            NavigationStack {
                VStack(spacing: 24) {

                    FinTrackText("My Budgets",
                              size: 16,
                              weight: .bold,
                              textAlignment: .center)
                        .padding(.top, 16)
                    
                    
                    NavigationLink(destination: CreateBudgetView().navigationBarBackButtonHidden(true), isActive: $isNavigating) {
                        EmptyBudgetView(onCreateBudget: {
                            isNavigating = true
                        })
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("backgroundColor").ignoresSafeArea())
            }
    }
}

#Preview {
    BudgetsView()
}
