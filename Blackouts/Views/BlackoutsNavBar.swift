//
//  BlackoutsNavBar.swift
//  Blackouts
//
//  Created by Vadim Shoshin on 23.12.2022.
//

import SwiftUI

struct BlackoutsNavBar: View {
    let delegate: ScheduleEditing?
    var onEdit: (() -> Void)?
    var body: some View {
        ZStack {
            Constants.bgColor
                .ignoresSafeArea()
            VStack {
                HStack {
                    Text("Blackouts")
                        .font(.system(size: 22, weight: .black, design: .serif))
                        .frame(alignment: .leading)
                        .padding(20)
                        .foregroundColor(.black)
                    Spacer()
                    Button(action: {
                        delegate?.editSchedule()
                    }) {
                        Image(systemName: "pencil.circle").renderingMode(.template)
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    .tint(.black)
                    .frame(minWidth: 30, minHeight: 30)
                    .padding(15)
                }
                Spacer()
            }
        }
        .shadow(radius: 0.5)
    }
}

// MARK: - ScheduleEditing

protocol ScheduleEditing {
    func editSchedule()
}

struct BlackoutsNavBar_Previews: PreviewProvider {
    static var previews: some View {
        BlackoutsNavBar(delegate: nil)
    }
}
