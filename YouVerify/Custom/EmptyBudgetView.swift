import SwiftUI

struct EmptyBudgetView: View {
    let onCreateBudget: () -> Void
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack(spacing: 16) {
                    Spacer()
                    
                    FinTrackText("Nothing to see here yet.",
                              size: 24,
                              weight: .bold)
                    
                    FinTrackText("Hi there, create a budget to get started.",
                              size: 16,
                              color: .gray)
                    
                    Button(action: onCreateBudget) {
                        FinTrackText("Create a budget",
                                  size: 16,
                                  color: .white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(Color("buttoncolor"))
                            .cornerRadius(28)
                            .padding(.horizontal, 24)
                            .padding(.top, 24)
                    }
                    
                    Spacer()
                }
                .padding(32)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.05), radius: 10)
                .padding(.horizontal, 24)
                .overlay(
                    Image("Target 3")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .opacity(0.2)
                        .offset(x: -geometry.size.width/3.15, y: geometry.size.height/2.38)
                )
                .overlay(
                    Image("Target 2")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .opacity(0.2)
                        .offset(x: geometry.size.width/3.1, y: -geometry.size.height/2.38)
                )
            }
        }
    }
}

#Preview {
    EmptyBudgetView(onCreateBudget: {})
        .frame(height: 500)
}

