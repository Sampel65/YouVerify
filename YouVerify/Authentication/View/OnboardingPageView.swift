import SwiftUI

struct OnboardingPageView: View {
    let page: OnboardingPage
    
    var body: some View {
        VStack(spacing: 24) {
            VStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(page.title.firstLine)
                        .font(.custom("Capriola-Regular", size: 32))
                        .fontWeight(.bold)
                    Text(page.title.secondLine)
                        .font(.custom("Capriola-Regular", size: 32))
                        .fontWeight(.bold)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(page.description)
                    .font(.custom("Capriola-Regular", size: 16))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 24)
            .padding(.top, 32)
            
            Spacer(minLength: 32)
            
            Image(page.image)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 24)
            
            Spacer()
        }
    }
}
