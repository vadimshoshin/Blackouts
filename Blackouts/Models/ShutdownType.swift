//
//  ShutdownType.swift
//  Blackouts
//
//  Created by Vadim Shoshin on 23.12.2022.
//

import Foundation

enum ShutdownType {
    case firstCycle
    case secondCycle
    case thirdCycle
    
    var periods: [Period] {
        switch self {
        case .firstCycle:
            return [ Period(timeFrame: "00:00\n03:00", powerMode: .lightsOn),
                     Period(timeFrame: "03:00\n06:00", powerMode: .possible),
                     Period(timeFrame: "06:00\n09:00", powerMode: .shutDown),
                     Period(timeFrame: "09:00\n12:00", powerMode: .lightsOn),
                     Period(timeFrame: "12:00\n15:00", powerMode: .possible),
                     Period(timeFrame: "15:00\n18:00", powerMode: .shutDown),
                     Period(timeFrame: "18:00\n21:00", powerMode: .lightsOn),
                     Period(timeFrame: "21:00\n00:00", powerMode: .possible) ]
            
        case .secondCycle:
            return [ Period(timeFrame: "00:00\n03:00", powerMode: .shutDown),
                     Period(timeFrame: "03:00\n06:00", powerMode: .lightsOn),
                     Period(timeFrame: "06:00\n09:00", powerMode: .possible),
                     Period(timeFrame: "09:00\n12:00", powerMode: .shutDown),
                     Period(timeFrame: "12:00\n15:00", powerMode: .lightsOn),
                     Period(timeFrame: "15:00\n18:00", powerMode: .possible),
                     Period(timeFrame: "18:00\n21:00", powerMode: .shutDown),
                     Period(timeFrame: "21:00\n00:00", powerMode: .lightsOn) ]
            
        case .thirdCycle:
            return [ Period(timeFrame: "00:00\n03:00", powerMode: .possible),
                     Period(timeFrame: "03:00\n06:00", powerMode: .shutDown),
                     Period(timeFrame: "06:00\n09:00", powerMode: .lightsOn),
                     Period(timeFrame: "09:00\n12:00", powerMode: .possible),
                     Period(timeFrame: "12:00\n15:00", powerMode: .shutDown),
                     Period(timeFrame: "15:00\n18:00", powerMode: .lightsOn),
                     Period(timeFrame: "18:00\n21:00", powerMode: .possible),
                     Period(timeFrame: "21:00\n00:00", powerMode: .shutDown) ]
        }
    }
}
