//
//  techEval9162024swiftui.swift
//  ReviewPractice9162024SwiftUI
//
//  Created by Consultant on 9/16/24.
//

import Foundation

struct Holidays: Decodable, Identifiable {
    var id: String { date }
    let date: String
    let localName: String
    let name: String
    let countryCode: String
    let fixed: Bool
    let global: Bool
    let counties: [String]?
    let launchYear: Int?
    let type: String
}
