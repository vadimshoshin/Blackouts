//
//  ContentView.swift
//  Blackouts
//
//  Created by Vadim Shoshin on 23.12.2022.
//

import SwiftUI

enum EditState {
    case allSet
    case monday
    case tuesday
    case wednesday
    
    var alertTitle: String {
        switch self {
        case .allSet:    return ""
        case .monday:    return "For Monday, Thursday, Sunday light between 00:00 and 03:00 is"
        case .tuesday:   return "For Tuesday and Friday light between 00:00 and 03:00 is"
        case .wednesday: return "For Tuesday and Saturday light between 00:00 and 03:00 is"
        }
    }
}

struct ContentView: View {
    @State var dayGroups: [DayModel] = UserDefaultsStorage.shared.schedule?.dayTypes ?? []
    @State var isEditing: Bool = false
    @State var editState: EditState = .allSet
    @State var newModels: [DayModel]? = nil
    
    var body: some View {
        if dayGroups.isEmpty {
            EmptyStateView(delegate: self)
                .actionSheet(isPresented: $isEditing, content: presentSheet)
        } else {
            VStack(spacing: 20) {
                BlackoutsNavBar(delegate: self)
                    .frame(maxHeight: 50)
                ScrollView([.horizontal], showsIndicators: false) {
                    HStack {
                        ForEach(dayGroups, id: \.id) { group in
                            DayView(day: group)
                        }
                    }
                }
                .actionSheet(isPresented: $isEditing, content: presentSheet)
            }
            .ignoresSafeArea(edges: [.bottom])
        }
    }
}

// MARK: - Private

private extension ContentView {
    
    func presentSheet() -> ActionSheet {
        let lightsOnButton = ActionSheet.Button.default(Text("On")) {
            processAlertSelection(.lightsOn)
            switchEditState()
        }
        
        let lightsOffButton = ActionSheet.Button.default(Text("Off")) {
            processAlertSelection(.shutDown)
            switchEditState()
        }
        
        let optionalButton = ActionSheet.Button.default(Text("Possibly off")) {
            processAlertSelection(.possible)
            switchEditState()
        }
        
        let actionSheet = ActionSheet(title: Text(editState.alertTitle),
                                      message: nil,
                                      buttons: [ lightsOnButton,
                                                 lightsOffButton,
                                                 optionalButton ])
        return actionSheet
    }
    
    func switchEditState() {
        switch editState {
        case .allSet: editState = .monday
        case .monday:
            editState = .tuesday
            isEditing = false
            scheduleNewAlertPresentation()
            
        case .tuesday:
            editState = .wednesday
            isEditing = false
            scheduleNewAlertPresentation()
            
        case .wednesday:
            editState = .allSet
            isEditing = false
            
        }
    }
    
    func scheduleNewAlertPresentation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            isEditing = true
        }
    }
    
    func processAlertSelection(_ type: PowerMode) {
        let shutdownType: ShutdownType
        switch type {
        case .lightsOn: shutdownType = .firstCycle
        case .shutDown: shutdownType = .secondCycle
        case .possible: shutdownType = .thirdCycle
        }
        
        switch editState {
        case .monday:
            newModels = [ DayModel(dayGroup: .monThuSun, shutdownType: shutdownType) ]
        case .tuesday:
            newModels?.append(DayModel(dayGroup: .tueFr, shutdownType: shutdownType))
        case .wednesday:
            newModels?.append(DayModel(dayGroup: .wedSat, shutdownType: shutdownType))
            dayGroups = newModels ?? []
            UserDefaultsStorage.shared.schedule = WeeklySchedule(dayTypes: dayGroups)
        default: return
        }
    }
}
// MARK: - ScheduleEditing

extension ContentView: ScheduleEditing {
    func editSchedule() {
        guard !isEditing else { return }
            editState = .monday
            isEditing = true
    }
}

// MARK: - PreviewProvider

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(dayGroups: [ DayModel(dayGroup: .monThuSun, shutdownType: .firstCycle),
                                 DayModel(dayGroup: .tueFr, shutdownType: .secondCycle),
                                 DayModel(dayGroup: .wedSat, shutdownType: .thirdCycle) ])
    }
}
