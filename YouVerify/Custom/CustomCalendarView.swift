import SwiftUI

struct CustomCalendarView: View {
    @Binding var startDate: Date?
    @Binding var endDate: Date?
    @Environment(\.dismiss) private var dismiss
    @State private var selectedDate: Date = Date()
    @State private var currentMonth: Date = Date()
    
    let calendar = Calendar.current
    
    var body: some View {
        VStack(spacing: 20) {
            // Header
            VStack(spacing: 16) {
                Text("Pick a start and end date")
                    .font(.capriolaRegular(size: 20))
                    .frame(maxWidth: .infinity)
            }
            
            // Month selection
            HStack {
                Text(monthYearString(from: currentMonth))
                    .font(.capriolaRegular(size: 18))
                
                Spacer()
                
                HStack(spacing: 16) {
                    Button(action: previousMonth) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                    }
                    
                    Button(action: nextMonth) {
                        Image(systemName: "chevron.right")
                            .foregroundColor(.black)
                    }
                }
            }
            
            // Weekday headers
            HStack {
                ForEach(["M", "T", "W", "T", "F", "S", "S"], id: \.self) { day in
                    Text(day)
                        .font(.capriolaRegular(size: 14))
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                }
            }
            
            // Calendar grid
            let days = daysInMonth()
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                ForEach(days, id: \.self) { date in
                    if let date = date {
                        dayView(for: date)
                    } else {
                        Text("")
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            
            // Date selection fields
            VStack(alignment: .leading, spacing: 16) {
                Text("Start date")
                    .font(.capriolaRegular(size: 16))
                
                TextField("Start date", text: .constant(startDate?.formatted(date: .abbreviated, time: .omitted) ?? ""))
                    .font(.capriolaRegular(size: 16))
                    .foregroundColor(.gray)
                    .disabled(true)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                    .background(Color.white)
                    .cornerRadius(12)
                
                Text("End date")
                    .font(.capriolaRegular(size: 16))
                
                TextField("End date", text: .constant(endDate?.formatted(date: .abbreviated, time: .omitted) ?? ""))
                    .font(.capriolaRegular(size: 16))
                    .foregroundColor(.gray)
                    .disabled(true)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                    .background(Color.white)
                    .cornerRadius(12)
            }
            
            Button(action: { dismiss() }) {
                Text("Save Date")
                    .font(.capriolaRegular(size: 16))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color("buttoncolor"))
                    .cornerRadius(12)
            }
        }
        .padding(24)
    }
    
    private func dayView(for date: Date) -> some View {
        let isSelected = calendar.isDate(date, inSameDayAs: selectedDate)
        
        return Button(action: { selectDate(date) }) {
            Text("\(calendar.component(.day, from: date))")
                .font(.capriolaRegular(size: 16))
                .foregroundColor(isSelected ? .white : .black)
                .frame(width: 40, height: 40)
                .background(isSelected ? Color("buttoncolor") : Color.clear)
                .cornerRadius(8)
        }
    }
    
    private func monthYearString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }
    
    private func daysInMonth() -> [Date?] {
        var days: [Date?] = []
        
        guard let range = calendar.range(of: .day, in: .month, for: currentMonth),
              let firstDay = calendar.date(from: calendar.dateComponents([.year, .month], from: currentMonth)) else {
            return []
        }
        
        let firstWeekday = calendar.component(.weekday, from: firstDay)
        
        // Add empty spaces for days before the first day of the month
        for _ in 0..<((firstWeekday - 2 + 7) % 7) {
            days.append(nil)
        }
        
        // Add all days in the month
        for day in range {
            guard let date = calendar.date(byAdding: .day, value: day - 1, to: firstDay) else { continue }
            days.append(date)
        }
        
        return days
    }
    
    private func selectDate(_ date: Date) {
        if startDate == nil {
            startDate = date
        } else if endDate == nil && date > startDate! {
            endDate = date
        } else {
            startDate = date
            endDate = nil
        }
    }
    
    private func previousMonth() {
        if let newDate = calendar.date(byAdding: .month, value: -1, to: currentMonth) {
            currentMonth = newDate
        }
    }
    
    private func nextMonth() {
        if let newDate = calendar.date(byAdding: .month, value: 1, to: currentMonth) {
            currentMonth = newDate
        }
    }
}

// End of file
