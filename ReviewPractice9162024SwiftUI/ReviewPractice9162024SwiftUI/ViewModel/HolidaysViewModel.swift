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
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
        fetchHolidays()
    }
    
    func fetchHolidays() {
        networkService.fetchHolidays()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] holidays in
                self?.holidays = holidays
            })
            .store(in: &cancellables)
    }
}
