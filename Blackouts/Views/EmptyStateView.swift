//
//  EmptyStateView.swift
//  Blackouts
//
//  Created by Vadim Shoshin on 23.12.2022.
//

import SwiftUI

struct EmptyStateView: View {
    var delegate: ScheduleEditing?
    
    var body: some View {
        ZStack(alignment: .center) {
            Constants.bgColor
            VStack(spacing: 15) {
                Text("No Schedule Found")
                    .font(.headline)
                    .padding(15)
                Image(systemName: "calendar.badge.exclamationmark")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(Color(UIColor(rgb: 0xFD8A8A)))
                    .frame(minWidth: 50, maxWidth: 120, minHeight: 50, maxHeight: 100)
                Button("Create Schedule") {
                    delegate?.editSchedule()
                }
                .font(.headline)
                .tint(.black)
                .padding(15)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .padding(15)
        .shadow(color: .black.opacity(0.2), radius: 5)
        .frame(maxHeight: 300)
    }
}

struct EmptyStateView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyStateView(delegate: nil)
    }
}
