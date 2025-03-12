import SwiftUI

enum SavingsStep: Int, CaseIterable {
    case goalName = 1
    case details
    case schedule
    case review
}

struct CreateSavingsGoalView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var currentStep: SavingsStep = .goalName
    @State private var goalName = ""
    @State private var category = ""
    @State private var goalAmount = ""
    @State private var savingFrequency = ""
    @State private var dateRange: ClosedRange<Date>? = nil
    
    let quickPicks = ["House rent", "School fees", "A car"]
    let frequencies = ["Daily", "Weekly", "Monthly", "Manually"]
    
    @State private var showingCalendar = false
    @State private var startDate: Date? = nil
    @State private var endDate: Date? = nil
    
    @State private var monthlyContribution = ""
    @State private var showingImagePicker = false
    @State private var selectedImage: UIImage? = nil
    @State private var selectedFundSource: FundSource? = nil
    
    let fundSources = [
        FundSource(name: "Kuda Bank", balance: "2,987.56", icon: "kuda")
    ]
    
    var body: some View {
        VStack(spacing: 24) {
            // Only show step counter in non-review steps
            if currentStep != .review {
                HStack {
                    Button(action: { dismiss() }) {
                                Image("back")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                    }
                    
                    Spacer()
                    
                    FinTrackText("\(currentStep.rawValue) of \(SavingsStep.allCases.count)",
                              size: 16,
                              color: .gray)
                    
                    Spacer()
                    
                    Circle()
                        .fill(Color.clear)
                        .frame(width: 40, height: 40)
                }
                .padding(.horizontal)
            }
            
            // Step Content
            switch currentStep {
            case .goalName:
                goalNameStep
            case .details:
                goalDetailsStep
            case .schedule:
                scheduleStep
            case .review:
                reviewStep
            }
            
            Spacer()
            
            Button(action: {
                withAnimation {
                    if let nextStep = SavingsStep(rawValue: currentStep.rawValue + 1) {
                        currentStep = nextStep
                    }
                }
            }) {
                FinTrackText("Next",
                          size: 16,
                          color: .white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color("orangeButton"))
                    .cornerRadius(12)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 32)
        }
        .background(Color("backgroundColor").ignoresSafeArea())
    }
    
    // MARK: - Step Views
    var goalNameStep: some View {
        VStack(alignment: .leading, spacing: 16) {
            setupHeader
            
            FinTrackText("What are you saving for?",
                      size: 16)
            
            CustomTextField(title: "", placeholder: "Enter the name of your budget here", text: $goalName)
            
            FinTrackText("Quick picks",
                      size: 16)
            
            HStack(spacing: 12) {
                ForEach(quickPicks, id: \.self) { pick in
                    Button(action: { goalName = pick }) {
                        FinTrackText(pick,
                                  size: 14,
                                  color: .gray)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(20)
                    }
                }
            }
        }
        .padding(.horizontal, 24)
    }
    
    var setupHeader: some View {
        VStack(spacing: 8) {
            FinTrackText("Create your saving goal",
                      size: 24)
            
            FinTrackText("Setup a personal savings goal. E.g Rent, or a car or a trip.",
                      size: 16,
                      color: .gray,
                      textAlignment: .center)
        }
        .padding()
    }
    
    var goalDetailsStep: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 32) {
                // Header Section
                VStack(spacing: 8) {
                    FinTrackText("Create your saving goal",
                              size: 24,
                              textAlignment: .center)
                        .frame(maxWidth: .infinity)
                    
                    FinTrackText("Setup a personal savings goal. E.g Rent, or a car or a trip.",
                              size: 16,
                              color: .gray,
                              textAlignment: .center)
                        .frame(maxWidth: .infinity)
                }
                .padding(.horizontal, 24)
                
                // Form Fields
                VStack(alignment: .leading, spacing: 24) {
                    // Goal Name Field
                    VStack(alignment: .leading, spacing: 8) {
                        FinTrackText("What are you saving for?",
                                  size: 16)
                        
                        FinTrackText(goalName,
                                  size: 16)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.white)
                            .cornerRadius(12)
                    }
                    
                    // Category Field
                    VStack(alignment: .leading, spacing: 8) {
                        FinTrackText("What category does this belong to?",
                                  size: 16)
                        
                        Menu {
                            Button("Housing", action: { category = "Housing" })
                            Button("Transportation", action: { category = "Transportation" })
                            Button("Education", action: { category = "Education" })
                        } label: {
                            HStack {
                                FinTrackText(category.isEmpty ? "Select a category" : category,
                                          size: 16,
                                          color: category.isEmpty ? .gray : .black)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.black)
                            }
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                            .background(Color.white)
                            .cornerRadius(12)
                        }
                    }
                    
                    // Goal Amount Field
                    VStack(alignment: .leading, spacing: 8) {
                        FinTrackText("What is your goal amount?",
                                  size: 16)
                        
                        TextField("", text: $goalAmount)
                            .font(.custom("Capriola-Regular", size: 16))
                            .keyboardType(.numberPad)
                            .placeholder(when: goalAmount.isEmpty) {
                                FinTrackText("₦ 200,000",
                                          size: 16,
                                          color: .gray)
                            }
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                            .background(Color.white)
                            .cornerRadius(12)
                    }
                    
                    // Saving Frequency Field
                    VStack(alignment: .leading, spacing: 8) {
                        FinTrackText("How will you prefer to save?",
                                  size: 16)
                        
                        HStack(spacing: 12) {
                            ForEach(frequencies, id: \.self) { frequency in
                                Button(action: { savingFrequency = frequency }) {
                                    FinTrackText(frequency,
                                              size: 12,
                                              color: savingFrequency == frequency ? .white : .black)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 8)
                                        .background(savingFrequency == frequency ? Color("orangeButton") : Color.black.opacity(0.05))
                                        .cornerRadius(20)
                                }
                            }
                        }
                    }
                    
                    // Date Range Field
                    VStack(alignment: .leading, spacing: 8) {
                        FinTrackText("What is the duration of your goal?",
                                  size: 16)
                        
                        Button(action: { showingCalendar = true }) {
                            HStack {
                                FinTrackText(startDate == nil ? "Pick a start and end date" : "\(startDate?.formatted(date: .abbreviated, time: .omitted) ?? "") - \(endDate?.formatted(date: .abbreviated, time: .omitted) ?? "")",
                                          size: 16,
                                          color: startDate == nil ? .gray : .black)
                                Spacer()
                                Image("calendar")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                            }
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                            .background(Color.white)
                            .cornerRadius(12)
                        }
                        .sheet(isPresented: $showingCalendar) {
                            CustomCalendarView(startDate: $startDate, endDate: $endDate)
                                .presentationDetents([.height(650)])
                        }
                    }
                }
                .padding(.horizontal, 24)
            }
        }
    }
    
    var scheduleStep: some View {

            VStack(alignment: .leading, spacing: 32) {
                setupHeader
                ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    // Monthly contribution
                    VStack(alignment: .leading, spacing: 16) {
                        FinTrackText("How much do you want to contribute monthly?",
                                  size: 16)
                        
                        TextField("", text: $monthlyContribution)
                            .font(.custom("Capriola-Regular", size: 16))
                            .keyboardType(.numberPad)
                            .placeholder(when: monthlyContribution.isEmpty) {
                                FinTrackText("₦ 250,000",
                                          size: 16,
                                          color: .gray)
                            }
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                            .background(Color.white)
                            .cornerRadius(12)
                    }
                    
                    // Image upload
                    VStack(alignment: .leading, spacing: 8) {
                        FinTrackText("Add a picture(optional)",
                                  size: 16)
                        
                        Button(action: { showingImagePicker = true }) {
                            VStack(spacing: 12) {
                                if let selectedImage = selectedImage {
                                    Image(uiImage: selectedImage)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxHeight: 200)
                                        .cornerRadius(12)
                                } else {
                                    VStack(spacing: 8) {
                                        Image("upload_placeholder")
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                        
                                        FinTrackText("Choose file to upload",
                                                  size: 16,
                                                  color: .black)
                                        
                                        FinTrackText("Formats: png, jpg, jpeg",
                                                  size: 14,
                                                  color: .gray)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 200)
                                    .background(Color.white)
                                    .cornerRadius(12)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                            .foregroundColor(.gray.opacity(0.5))
                                    }
                                }
                            }
                        }
                    }
                    
                    // Fund source
                    VStack(alignment: .leading, spacing: 16) {
                        FinTrackText("Fund source",
                                  size: 16)
                        
                        Menu {
                            ForEach(fundSources, id: \.name) { source in
                                Button(source.name) {
                                    selectedFundSource = source
                                }
                            }
                        } label: {
                            HStack {
                                FinTrackText(selectedFundSource?.name ?? "Select another account",
                                          size: 16,
                                          color: selectedFundSource == nil ? .gray : .black)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.black)
                            }
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                            .background(Color.white)
                            .cornerRadius(12)
                        }
                        
                        if let source = selectedFundSource {
                            HStack(spacing: 12) {
                                Image(source.icon)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 48, height: 48)
                                    .cornerRadius(8)
                                    .background(Color.purple)
                                
                                VStack(alignment: .leading) {
                                    FinTrackText(source.name,
                                              size: 16)
                                    FinTrackText("Account balance: ₦\(source.balance)",
                                              size: 14,
                                              color: .gray)
                                }
                            }
                            .padding(12)
                            .background(Color.white)
                            .cornerRadius(12)
                        }
                    }
                }
                .padding(.horizontal, 24)
                
                Spacer()
                    .frame(height: 32)
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $selectedImage)
        }
    }
    
    var reviewStep: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 24) {
                // Header for review step
                HStack {
                    Button(action: { dismiss() }) {
                        Circle()
                            .fill(Color("buttoncolor").opacity(0.1))
                            .frame(width: 40, height: 40)
                            .overlay {
                                Image("back")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                            }
                    }
                    
                    Spacer()
                    
                    FinTrackText("Saving goal preview",
                              size: 20)
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                // Goal Preview Card
                VStack(alignment: .leading, spacing: 8) {
                    if let selectedImage = selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 116, height: 116)
                            .cornerRadius(12)
                    } else {
                        Rectangle()
                            .fill(Color.gray.opacity(0.1))
                            .frame(width: 116, height: 116)
                            .cornerRadius(12)
                    }
                    
                    FinTrackText("Trip to Kenya",
                              size: 16)
                    
                    HStack(spacing: 24) {
                        VStack(alignment: .leading, spacing: 2) {
                            FinTrackText("₦ 0",
                                      size: 16)
                            FinTrackText("Saved",
                                      size: 14,
                                      color: .gray)
                        }
                        
                        VStack(alignment: .leading, spacing: 2) {
                            FinTrackText("₦ 500,000.00",
                                      size: 16)
                            FinTrackText("Total Goal",
                                      size: 14,
                                      color: .gray)
                        }
                    }
                    
                    // Progress bar
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(Color("orangeButton").opacity(0.2))
                            .frame(height: 4)
                        
                        Rectangle()
                            .fill(Color("orangeButton"))
                            .frame(width: 0, height: 4)
                    }
                    
                    FinTrackText("0%",
                              size: 14,
                              color: .gray)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(16)
                .background(Color.white)
                .cornerRadius(12)
                
                // Fund Source Section
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        FinTrackText("Fund source",
                                  size: 16)
                        Spacer()
                        Button(action: {}) {
                            FinTrackText("Change >",
                                      size: 14,
                                      color: Color("orangeButton"))
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color("orangeButton").opacity(0.1))
                                .cornerRadius(16)
                        }
                    }
                    
                    HStack(spacing: 12) {
                        Image("kuda")
                            .resizable()
                            .frame(width: 48, height: 48)
                            .background(Color.purple)
                            .cornerRadius(8)
                        
                        VStack(alignment: .leading) {
                            FinTrackText("Kuda Bank",
                                      size: 16)
                            FinTrackText("Account balance: ₦2,987.56",
                                      size: 14,
                                      color: .gray)
                        }
                    }
                    .padding(12)
                    .background(Color.white)
                    .cornerRadius(12)
                }
                
                // Goal Duration Section
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        FinTrackText("Goal duration",
                                  size: 16)
                        Spacer()
                        Button(action: {}) {
                            FinTrackText("Change >",
                                      size: 14,
                                      color: Color("orangeButton"))
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color("orangeButton").opacity(0.1))
                                .cornerRadius(16)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 32) {
                            VStack(alignment: .leading) {
                                FinTrackText("16/07/2024",
                                          size: 16)
                                FinTrackText("Start date",
                                          size: 14,
                                          color: .gray)
                            }
                            
                            VStack(alignment: .leading) {
                                FinTrackText("26/07/2024",
                                          size: 16)
                                FinTrackText("End date",
                                          size: 14,
                                          color: .gray)
                            }
                        }
                    }
                    .padding(12)
                    .background(Color.white)
                    .cornerRadius(12)
                }
                
                // More Details Section
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        FinTrackText("More details",
                                  size: 16)
                        Spacer()
                        Button(action: {}) {
                            FinTrackText("Change >",
                                      size: 14,
                                      color: Color("orangeButton"))
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color("orangeButton").opacity(0.1))
                                .cornerRadius(16)
                        }
                    }
                    
                    HStack(spacing: 32) {
                        VStack(alignment: .leading) {
                            FinTrackText("Daily",
                                      size: 16)
                            FinTrackText("Frequency",
                                      size: 14,
                                      color: .gray)
                        }
                        
                        VStack(alignment: .leading) {
                            FinTrackText("25 days",
                                      size: 16)
                            FinTrackText("Days left",
                                      size: 14,
                                      color: .gray)
                        }
                        
                        VStack(alignment: .leading) {
                            FinTrackText("₦ 250,000",
                                      size: 16)
                            FinTrackText("Amount per month",
                                      size: 14,
                                      color: .gray)
                        }
                    }
                    .padding(12)
                    .background(Color.white)
                    .cornerRadius(12)
                }
                
                // Receive Alert Section
                VStack(alignment: .leading, spacing: 16) {
                    FinTrackText("Recieve alert",
                              size: 16)
                    
                    HStack {
                        FinTrackText("Receive alert when it reaches a certain limit",
                                  size: 14,
                                  color: .gray)
                        Spacer()
                        Toggle("", isOn: .constant(false))
                    }
                    .padding(12)
                    .background(Color.white)
                    .cornerRadius(12)
                }
                
                Button(action: {}) {
                    FinTrackText("Create saving goal",
                              size: 16,
                              color: .white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color("orangeButton"))
                        .cornerRadius(12)
                }
            }
            .padding(.horizontal, 24)
        }
        .background(Color("backgroundColor"))
    }
}
