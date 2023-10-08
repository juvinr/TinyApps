//
//  ContentView.swift
//  DatePicker
//
//  Created by Juvin Rodrigues on 07/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var date = Date.now
    @State private var dateText = Constants.placeholderText
    @State private var datePickerState: DatePickerState = .hidden
    @State private var isDateSelected = false
    @State private var offset: CGFloat = 1000

    private let dateFormat = Constants.dateFormat

    var selectedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: date)
    }

    var body: some View {
        ZStack {
            DatePickerView(
                datePickerState: $datePickerState,
                dateText: $dateText,
                isDateSelected: $isDateSelected,
                offset: $offset
            )
            if datePickerState == .visible {
                CalendarView(
                    date: $date,
                    datePickerState: $datePickerState,
                    isDateSelected: $isDateSelected,
                    offset: $offset
                )
            }
        }
        .onChange(of: datePickerState) { _ in
            if isDateSelected {
                dateText = selectedDate
            } else {
                dateText = Constants.placeholderText
            }
        }
    }
}

struct DatePickerView : View {

    @Binding var datePickerState: DatePickerState
    @Binding var dateText: String
    @Binding var isDateSelected: Bool
    @Binding var offset: CGFloat

    var body: some View {
        VStack {
            Button {
                datePickerState = .visible
                withAnimation(.spring()) {
                    offset = 0
                }
            } label: {
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                        .fill(.gray.opacity(0.1))
                        .frame(height: 50)
                        .padding()
                    HStack {
                        Text(dateText)
                            .font(.callout.bold())
                            .foregroundColor(isDateSelected ? .black : .black.opacity(0.5))
                            .padding(.leading, 25)
                        Spacer()
                        Image(systemName: "calendar")
                            .font(.title2)
                            .foregroundColor(.black.opacity(0.5))
                            .padding(.trailing, 30)
                    }

                }
            }
        }
    }
}

struct CalendarView: View {

    @Binding var date: Date
    @Binding var datePickerState: DatePickerState
    @Binding var isDateSelected: Bool
    @Binding var offset: CGFloat

    var body: some View {
        VStack {
            DatePicker("", selection: $date, displayedComponents: .date)
                .datePickerStyle(.graphical)
                .id(date)
                .padding()
            HStack(spacing: 30) {
                Spacer()
                Button("Cancel") {
                    date = Date.now
                    withAnimation(.spring()) {
                        isDateSelected = false
                        datePickerState = .hidden
                        offset = 1000
                    }
                }
                Button("OK") {
                    withAnimation(.spring()) {
                        isDateSelected = true
                        datePickerState = .hidden
                        offset = 1000
                    }
                }
            }
            .padding(.trailing, 30)
            .padding(.bottom)
        }
        .background(.white)
        .cornerRadius(20, antialiased: true)
        .shadow(radius: 20)
        .padding(20)
        .offset(x: 0, y: offset)
    }
}

enum DatePickerState {
    case hidden
    case visible
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
