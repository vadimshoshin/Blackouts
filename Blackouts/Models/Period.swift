//
//  Period.swift
//  Blackouts
//
//  Created by Vadim Shoshin on 23.12.2022.
//

import Foundation
import UIKit
import SwiftUI

enum PowerMode: Codable {
    case lightsOn
    case possible
    case shutDown
    
    var bgColor: UIColor {
        switch self {
        case .lightsOn: return UIColor(rgb: 0x86C8BC)
        case .possible: return UIColor(rgb: 0xF1F7B5)
        case .shutDown: return UIColor(rgb: 0xFD8A8A)
        }
    }
    
    var image: Image {
        switch self {
        case .lightsOn: return Image("lightsOn")
        case .possible: return Image("unknown")
        case .shutDown: return Image("lightsOff")
        }
    }
}

struct Period: Codable {
    var id: String = UUID().uuidString
    let timeFrame: String
    let powerMode: PowerMode
}
