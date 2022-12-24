//
//  File.swift
//  Blackouts
//
//  Created by Vadim Shoshin on 23.12.2022.
//

import Foundation

protocol LocalStorage: AnyObject {
    var schedule: WeeklySchedule? { get set }
}

final class UserDefaultsStorage: LocalStorage {
    static let shared = UserDefaultsStorage()
    private let scheduleKey = "com.vadimshoshin.shutdownsSchedule"
    
    var schedule: WeeklySchedule? {
        get {
            return loadSchedule()
        } set {
            saveSchedule(newValue)
        }
    }
    
    private init() { }
}

// MARK: - Private

private extension UserDefaultsStorage {
    func saveSchedule(_ schedule: WeeklySchedule?) {
        guard let schedule = schedule else {
            UserDefaults.standard.removeObject(forKey: scheduleKey)
            return
        }
        
        guard let encodedData = try? JSONEncoder().encode(schedule) else {
            debugPrint("Failed to encode")
            return
        }
        
        UserDefaults.standard.set(encodedData, forKey: scheduleKey)
    }
    
    func loadSchedule() -> WeeklySchedule? {
        guard let data = UserDefaults.standard.data(forKey: scheduleKey) else {
            debugPrint("No data found")
            return nil
        }
        
        guard let schedule = try? JSONDecoder().decode(WeeklySchedule.self, from: data) else {
            debugPrint("Failed to decode")
            return nil
        }
        
        return schedule
    }
}
