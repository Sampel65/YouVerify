import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tag(0)
            
            BudgetsView()
                .tag(1)
            
            SavingsView()
                .tag(2)
            
            ExpensesView()
                .tag(3)
            
            AccountView()
                .tag(4)
        }
        .overlay(alignment: .bottom) {
            CustomTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    MainTabView()
}
