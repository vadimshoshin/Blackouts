//
//  DayGroup.swift
//  Blackouts
//
//  Created by Vadim Shoshin on 23.12.2022.
//

import Foundation

enum DayGroup: Codable {
    case monThuSun
    case tueFr
    case wedSat
    
    var title: String {
        switch self {
        case .tueFr: return "Tue, Fri"
        case .wedSat: return "Wed, Sat"
        case .monThuSun: return "Mon, Thu, Sun"
        }
    }
}
