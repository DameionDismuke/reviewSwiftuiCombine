//
//  HolidaysViewModel.swift
//  ReviewPractice9162024SwiftUI
//
//  Created by Consultant on 9/16/24.
//

import Foundation
import Combine

class HolidaysViewModel: ObservableObject {
    @Published var holidays: [Holidays] = []
    @Published var errorMessage: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchHolidays()
    }
    
    func fetchHolidays() {
        guard let url = URL(string: "https://date.nager.at/api/v2/publicholidays/2024/US") else {
            errorMessage = "URL isn't working"
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Holidays].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] holidays in
                self?.holidays = holidays
            })
            .store(in: &cancellables)
    }
}
