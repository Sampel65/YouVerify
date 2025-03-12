import SwiftUI

struct SearchTextField: View {
    @Binding var text: String
    let placeholder: String
    
    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(Color.black.opacity(0.03))
                .frame(width: 32, height: 32)
                .overlay {
                    Image("search")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .foregroundColor(.black.opacity(0.3))
                }
            
            TextField("", text: $text)
                .placeholder(when: text.isEmpty) {
                    Text(placeholder)
                        .foregroundColor(.black.opacity(0.3))
                        .font(.capriolaRegular(size: 16))
                }
                .font(.capriolaRegular(size: 16))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.black.opacity(0.03))
        .cornerRadius(12)
    }
}

// Custom View Modifier for placeholder
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

