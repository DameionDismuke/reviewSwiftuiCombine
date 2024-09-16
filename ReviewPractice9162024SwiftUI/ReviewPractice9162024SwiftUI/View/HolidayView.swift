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
        .alert(isPresented: .constant(!viewModel.errorMessage.isEmpty)) {
            Alert(title: Text("Error"),
                  message: Text(viewModel.errorMessage),
                  dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    HolidayView()
}
