//
//  DateExtension.swift
//  Accedo iOS Developer Test Project
//
//  Created by Abu Umair Jihan on 2022-04-01.
//

import Foundation

extension Date {
    var iSPassed24Hours: Bool {
        return (Calendar.current.dateComponents([.hour], from: self, to: Date()).hour ?? .zero) > 24
    }
}
