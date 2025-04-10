//
//  ContentView.swift
//  PeepORpoop
//
//  Created by Денис Меркотун on 03.04.2025.
//

import MapKit
import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        Map(initialPosition: viewModel.cameraPosition){
            UserAnnotation()
        }
        .onAppear {
            viewModel.checkUfLicationServiceIsEnabled()
        }
    }
}

#Preview {
    ContentView()
}


final class ContentViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var cameraPosition: MapCameraPosition = .region(.init(center: .init(latitude: 37.3346, longitude: -122.0090),latitudinalMeters: 1300, longitudinalMeters: 1300))
    
    var locationManager = CLLocationManager()
    
    func checkUfLicationServiceIsEnabled() {
        guard CLLocationManager.locationServicesEnabled() else {
                print("Location services are disabled. Show alert to user.")
                return
            }

            // Initialize the location manager safely
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    private func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted due to parental controls.")
        case .denied:
            print("You have denied this app location permission")
        case .authorizedAlways, .authorizedWhenInUse:
            cameraPosition = .region(MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.05)))
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}
