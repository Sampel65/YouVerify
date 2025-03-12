import SwiftUI

enum FinanceCardImageType {
    case wallet
    case piggyBank
    case target
    case expenses
    
    var imageName: String {
        switch self {
        case .wallet: return "wallet"
        case .piggyBank: return "piggy-bank"
        case .target: return "target"
        case .expenses: return "expenses"
        }
    }
}

struct FinanceCard: View {
    let title: String
    let amount: String
    let description: String
    let actionText: String
    let backgroundColor: Color
    let imageType: FinanceCardImageType
    
    private var textColor: Color {
        return imageType == .expenses ? .black : .white
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text(title)
                        .font(.capriolaRegular(size: 14))
                        .foregroundColor(textColor)
                    
                    Spacer()
                    
                    Button(action: {}) {
                        HStack(spacing: 4) {
                            Text(actionText)
                                .font(.capriolaRegular(size: 10))
                            Image(systemName: "chevron.right")
                                .font(.capriolaRegular(size: 8))
                        }
                        .foregroundColor(backgroundColor)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.white)
                        .cornerRadius(16)
                    }
                }
                
                HStack(spacing: 8) {
                    Text(amount)
                        .font(.capriolaRegular(size: 24))
                        .foregroundColor(textColor)
                        .bold()
                    
                    Button(action: {}) {
                        Image(systemName: "eye")
                            .foregroundColor(textColor)
                    }
                }
                
                Text(description)
                    .font(.capriolaRegular(size: 12))
                    .foregroundColor(textColor)
                    .multilineTextAlignment(.leading)
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(imageType.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 160, height: 160)
                .offset(x: 40, y: 40)
                .opacity(0.15)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 180)
        .background(backgroundColor)
        .cornerRadius(16)
    }
}
