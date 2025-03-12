import SwiftUI

struct CreateBudgetView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var currentStep = 1
    @State private var budgetData = BudgetCreationData()
    @State private var selectedStartDate: Date? = nil
    @State private var selectedEndDate: Date? = nil
    @State private var selectedFundSource: FundSource? = nil
    
    var body: some View {
        Group {
            switch currentStep {
            case 1:
                CreateBudgetStep1View(currentStep: $currentStep, budgetData: $budgetData)
            case 2:
                CreateBudgetStep2View(currentStep: $currentStep,
                                    budgetData: $budgetData,
                                    selectedStartDate: $selectedStartDate,
                                    selectedEndDate: $selectedEndDate,
                                    selectedFundSource: $selectedFundSource)
            case 3:
                BudgetPreviewView(budgetData: budgetData,
                                selectedStartDate: selectedStartDate,
                                selectedEndDate: selectedEndDate,
                                selectedFundSource: selectedFundSource)
            default:
                EmptyView()
            }
        }
    }
}
