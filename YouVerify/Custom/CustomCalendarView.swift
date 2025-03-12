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
                    .foregroundColor(Color("orangeButton"))
                
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
                ForEach([
                    ("M", "Monday"),
                    ("T", "Tuesday"),
                    ("W", "Wednesday"),
                    ("T", "Thursday"),
                    ("F", "Friday"),
                    ("S", "Saturday"),
                    ("S", "Sunday")
                ], id: \.1) { day in
                    Text(day.0)
                        .font(.capriolaRegular(size: 14))
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                }
            }
            
            // Calendar grid
            let days = daysInMonth()
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                ForEach(Array(days.enumerated()), id: \.offset) { index, date in
                    if let date = date {
                        dayView(for: date)
                    } else {
                        Text("")
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            
            // Date selection fields
            dateFieldsSection
            
            Button(action: { dismiss() }) {
                Text("Save Date")
                    .font(.capriolaRegular(size: 16))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color("orangeButton"))
                    .cornerRadius(20)
            }
        }
        .padding(24)
        .background(Color.white)
    }
    
    private func dayView(for date: Date) -> some View {
        let isStartDate = startDate.map { calendar.isDate(date, inSameDayAs: $0) } ?? false
        let isEndDate = endDate.map { calendar.isDate(date, inSameDayAs: $0) } ?? false
        let isInRange = isDateInRange(date)
        
        return Button(action: { selectDate(date) }) {
            Text("\(calendar.component(.day, from: date))")
                .font(.capriolaRegular(size: 16))
                .foregroundColor(isStartDate || isEndDate ? .white : (isInRange ? .black : .black))
                .frame(width: 40, height: 40)
                .background(
                    Group {
                        if isStartDate || isEndDate {
                            Color("orangeButton")
                        } else if isInRange {
                            Color("orangeButton").opacity(0.2)
                        } else {
                            Color.clear
                        }
                    }
                )
                .cornerRadius(8)
        }
    }
    
    private func isDateInRange(_ date: Date) -> Bool {
        guard let start = startDate, let end = endDate else { return false }
        return date >= start && date <= end
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
        
        for _ in 0..<((firstWeekday - 2 + 7) % 7) {
            days.append(nil)
        }
        

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
    
    private func formatDate(_ date: Date?) -> String {
        guard let date = date else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: date)
    }
    
    var dateFieldsSection: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading) {
                Text("Start date")
                    .font(.capriolaRegular(size: 16))
                
                Text(startDate != nil ? formatDate(startDate) : "Start date")
                    .font(.capriolaRegular(size: 16))
                    .foregroundColor(startDate != nil ? .black : .gray)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.white)
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                    }
            }
            
            VStack(alignment: .leading) {
                Text("End date")
                    .font(.capriolaRegular(size: 16))
                
                Text(endDate != nil ? formatDate(endDate) : "End date")
                    .font(.capriolaRegular(size: 16))
                    .foregroundColor(endDate != nil ? .black : .gray)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.white)
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                    }
            }
        }
    }
}
