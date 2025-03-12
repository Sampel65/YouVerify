//
//  OnboardingPage.swift
//  YouVerify
//
//  Created by Samson Oluwapelumi on 10/03/2025.
//

import Foundation

struct OnboardingPage: Identifiable {
    let id = UUID()
    let image: String
    let title: OnboardingTitle 
    let description: String
}

struct OnboardingTitle {
    let firstLine: String
    let secondLine: String
}
