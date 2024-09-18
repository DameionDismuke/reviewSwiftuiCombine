//
//  HolidayView.swift
//  ReviewPractice9162024SwiftUI
//
//  Created by Consultant on 9/16/24.
//

import SwiftUI

struct HolidayView: View {
    @StateObject private var viewModel = HolidaysViewModel()

    var body: some View {
        NavigationView {
            if viewModel.holidays.isEmpty {
                VStack {
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    } else {
                        Text("No holidays available.")
                            .padding()
                    }
                }
            } else {
                List(viewModel.holidays) { holiday in
                    NavigationLink(destination: HolidetailView(holiday: holiday)) {
                        VStack(alignment: .leading) {
                            Text(holiday.localName)
                                .font(.headline)
                            Text(holiday.date)
                                .font(.subheadline)
                        }
                    }
                }
                .navigationTitle("Holidays")
                .onAppear {
                    viewModel.fetchHolidays()
                }
            }
        }
    }
}

#Preview {
    HolidayView()
}
