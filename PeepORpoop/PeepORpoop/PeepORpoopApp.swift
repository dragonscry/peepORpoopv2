//
//  PeepORpoopApp.swift
//  PeepORpoop
//
//  Created by Денис Меркотун on 03.04.2025.
//

import SwiftUI

@main
struct PeepORpoopApp: App {
    @State private var locationManager = LocationManager()
    var body: some Scene {
        WindowGroup {
            
            ContentView()
        }
        .environment(locationManager)
    }
    
}
