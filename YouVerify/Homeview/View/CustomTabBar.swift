import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack(spacing: 0) {
  
            TabBarButton(imageName: "home", selectedImageName: "home2", title: "Home", isSelected: selectedTab == 0)
                .onTapGesture { selectedTab = 0 }
            
            TabBarButton(imageName: "budget", selectedImageName: "budget2", title: "Budgets", isSelected: selectedTab == 1)
                .onTapGesture { selectedTab = 1 }
            
            TabBarButton(imageName: "savings", selectedImageName: "savings2", title: "Savings", isSelected: selectedTab == 2)
                .onTapGesture { selectedTab = 2 }
            
            TabBarButton(imageName: "expenses 1", selectedImageName: "expenses2", title: "Expenses", isSelected: selectedTab == 3)
                .onTapGesture { selectedTab = 3 }
            
            TabBarButton(imageName: "account", selectedImageName: "account2", title: "Account", isSelected: selectedTab == 4)
                .onTapGesture { selectedTab = 4 }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color.white)
    }
}


struct TabBarButton: View {

    let imageName: String
    let selectedImageName: String
    let title: String
    let isSelected: Bool
    
    var body: some View {
        VStack(spacing: 4) {
            Image(isSelected ? selectedImageName : imageName)
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
                .foregroundColor(isSelected ? Color("buttoncolor") : .gray)
                .contentShape(Rectangle())
            
            Text(title)
                .font(.capriolaRegular(size: 10))
                .foregroundColor(isSelected ? Color("buttoncolor") : .gray)
        }
        .frame(maxWidth: .infinity)
    }
}
struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CustomTabBar(selectedTab: .constant(0))
        }
    }
}
