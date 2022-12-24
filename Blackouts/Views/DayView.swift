//
//  DayView.swift
//  Blackouts
//
//  Created by Vadim Shoshin on 23.12.2022.
//

import SwiftUI

struct DayView: View {
    
    let cellHeight: CGFloat = 70
    
    
    @State var day: DayModel
    
    var body: some View {
        ScrollView([.vertical], showsIndicators: false) {
            HStack {
                VStack {
                    ZStack {
                        Constants.bgColor
                        Text("Time")
                            .font(.headline)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .frame(minWidth: 70, minHeight: cellHeight)
                    .shadow(color: .black.opacity(0.1), radius: 1)
                    
                    ForEach(day.periods, id: \.id) { period in
                        ZStack {
                            Constants.bgColor
                            Text(period.timeFrame)
                                .font(.headline)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                    .frame(minHeight: cellHeight)
                    .shadow(color: .black.opacity(0.1), radius: 1)
                    
                }
                VStack {
                    ZStack {
                        Constants.bgColor
                        Text(day.dayGroup.title)
                            .fixedSize(horizontal: false, vertical: true)
                            .fontWeight(.semibold)
                            .padding(15)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .frame(minHeight: cellHeight)
                    .shadow(color: .black.opacity(0.1), radius: 1)
                    
                    ForEach(day.periods, id: \.id) {
                        PeriodView(period: $0)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .shadow(color: .black.opacity(0.15), radius: 1)
                            .frame(minWidth: cellHeight, minHeight: cellHeight)
                            
                    }
                }
                .frame(width: (UIScreen.main.bounds.width - 15 * 2) / 3)
            }
            
            .padding(10)
        }
    }
}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView(day: DayModel(dayGroup: .monThuSun, shutdownType: .firstCycle))
    }
}
