import SwiftUI

struct Popup<Content: View>: View {
    @Binding var isPresented: Bool
    let content: Content
    let dismissOnTapOutside: Bool
    
    private let buttonSize: CGFloat = 24
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.gray.opacity(0.7))
                .ignoresSafeArea()
                .onTapGesture {
                    if dismissOnTapOutside {
                        withAnimation {
                            isPresented = false
                        }
                    }
                }
            
            content
                .frame(width: UIScreen.main.bounds.size.width - 100)
                .padding(24)
                .background(Color("buttoncolor"))
                .cornerRadius(20)
                .padding(.horizontal, 32)
        }
        .ignoresSafeArea(.all)
        .frame(
            width: UIScreen.main.bounds.size.width,
            height: UIScreen.main.bounds.size.height,
            alignment: .center
        )
    }
}

extension Popup {
    init(isPresented: Binding<Bool>,
         dismissOnTapOutside: Bool = true,
         @ViewBuilder _ content: () -> Content) {
        _isPresented = isPresented
        self.dismissOnTapOutside = dismissOnTapOutside
        self.content = content()
    }
}

