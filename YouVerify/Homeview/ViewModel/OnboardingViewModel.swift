//
//  OnboardingViewModel.swift
//  YouVerify
//
//  Created by Samson Oluwapelumi on 10/03/2025.
//

import Foundation


class OnboardingViewModel: ObservableObject {
    @Published var currentPage = 0
    @Published var showingCreateAccount = false
    
    let onboardingPages = [
        OnboardingPage(
            image: "track_expenses",
            title: OnboardingTitle(
                firstLine: "Track Your",
                secondLine: "Expenses"
            ),
            description: "Get insights into where your money goes and make informed financial decisions."
        ),
        OnboardingPage(
            image: "savings_goals",
            title: OnboardingTitle(
                firstLine: "Set Savings",
                secondLine: "Goals"
            ),
            description: "Whether it's for a vacation, a new car, or an emergency fund, we help you stay on track."
        ),
        OnboardingPage(
            image: "financial_insights",
            title: OnboardingTitle(
                firstLine: "Get Financial",
                secondLine: "Insights"
            ),
            description: "Access detailed reports and analytics to make better financial choices."
        )
    ]
    
    var isLastPage: Bool {
        currentPage == onboardingPages.count - 1
    }
    
    func nextPage() {
        if !isLastPage {
            currentPage += 1
        }
    }
    
    func handleCreateAccount() {
        showingCreateAccount = true
    }
    
    func handleSignIn() {

    }
}
