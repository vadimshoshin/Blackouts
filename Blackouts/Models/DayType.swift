//
//  DayType.swift
//  Blackouts
//
//  Created by Vadim Shoshin on 23.12.2022.
//

import Foundation

struct DayModel: Codable {
    var id: String = UUID().uuidString
    let dayGroup: DayGroup
    let periods: [Period]
    
    init(dayGroup: DayGroup, shutdownType: ShutdownType) {
        self.dayGroup = dayGroup
        self.periods = shutdownType.periods
    }
}

// MARK: - Views generator
extension DayModel {
    var periodViews: [PeriodView] {
        return periods.map({ PeriodView(period: $0) })
    }
}
