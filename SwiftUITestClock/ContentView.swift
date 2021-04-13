//
//  ContentView.swift
//  SwiftUITestClock
//
//  Created by Keenan Hauber on 23/9/20.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var clock = Clock(updatesPerSecond: 60.0)

    var body: some View {
        ZStack {
            Circle()
            GeometryReader { geometry in
                // For some reason the compiler struggles with type-checking ForEach(1...12) – so use 1..<13 instead
                ForEach(1..<13) { hour in

                    let scale = min(geometry.size.width, geometry.size.height) * 0.45
                    let midX = geometry.size.width / 2
                    let midY = geometry.size.height / 2
                    let angle = CGFloat.tau/12 * CGFloat(hour)

                    Text(String(hour)).position(x: midX + sin(angle) * scale, y: midY + cos(angle) * scale * -1)

                }.foregroundColor(.white)
            }

            let currentTime = clock.currentTime

            // Combine values to have a smoothly-moving clock
            let secondsValue = CGFloat(currentTime.seconds) + (CGFloat(currentTime.nanoseconds) / 1_000_000_000)
            let minutesValue = CGFloat(currentTime.minutes) + secondsValue / 60
            let hoursValue = CGFloat(currentTime.hours) + minutesValue / 60

            ClockHand(value: hoursValue, increments: 12.0, scale: 0.4).stroke(lineWidth: 2.0).fill(Color.white)
            ClockHand(value: minutesValue, increments: 60.0, scale: 0.6).stroke(lineWidth: 1.0).fill(Color.white)
            ClockHand(value: secondsValue, increments: 60.0, scale: 0.7).stroke(lineWidth: 1.0).fill(Color.red)
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
