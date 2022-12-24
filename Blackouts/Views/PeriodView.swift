//
//  PeriodView.swift
//  Blackouts
//
//  Created by Vadim Shoshin on 23.12.2022.
//

import SwiftUI

struct PeriodView: View {
    @State var period: Period
    
    var body: some View {
        ZStack {
            Color(period.powerMode.bgColor)
            period.powerMode.image
                .resizable()
                .frame(maxWidth: 50, maxHeight: 50, alignment: .center)
        }
    }
}

struct PeriodView_Previews: PreviewProvider {
    static var previews: some View {
        PeriodView(period: .init(timeFrame: "00:00", powerMode: .lightsOn))
    }
}
