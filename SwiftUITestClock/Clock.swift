//
//  Clock.swift
//  SwiftUITestClock
//
//  Created by Keenan Hauber on 14/4/21.
//

import Foundation

class Clock: ObservableObject {

    init(updatesPerSecond: Double) {
        currentTime = Clock.nextTime()
        updateTimer = Timer.scheduledTimer(withTimeInterval: 1 / updatesPerSecond, repeats: true, block: { [weak self] _ in
            self?.currentTime = Clock.nextTime()
        })
    }

    private var updateTimer: Timer!
    @Published var currentTime: Time

    private static func nextTime() -> Time {
        let now = Date()
        let calendar = Calendar.current

        let time = Time(
            hours: calendar.component(.hour, from: now),
            minutes: calendar.component(.minute, from: now),
            seconds: calendar.component(.second, from: now),
            nanoseconds: calendar.component(.nanosecond, from: now)
        )

        return time
    }

    struct Time {
        var hours: Int
        var minutes: Int
        var seconds: Int
        var nanoseconds: Int
    }
}
