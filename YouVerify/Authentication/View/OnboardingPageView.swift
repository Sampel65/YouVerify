//
//  OnboardingPageView.swift
//  YouVerify
//
//  Created by Samson Oluwapelumi on 10/03/2025.
//

import SwiftUI

struct OnboardingPageView: View {
    let page: OnboardingPage
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack(spacing: 24) {
            VStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    FinTrackText(page.title.firstLine,
                              size: 32,
                              weight: .bold,
                              textAlignment: .leading)
                        .font(.custom("Capriola-Regular", size: 32))
                    FinTrackText(page.title.secondLine,
                              size: 32,
                              weight: .bold,
                              textAlignment: .leading)
                        .font(.custom("Capriola-Regular", size: 32))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                FinTrackText(page.description,
                          size: 16,
                          textAlignment: .leading)
                    .font(.custom("Capriola-Regular", size: 16))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
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
