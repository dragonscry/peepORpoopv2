//
//  MapViewModel.swift
//  PeepORpoop
//
//  Created by Денис Меркотун on 09.04.2025.
//

import Foundation
import CoreLocation
import _MapKit_SwiftUI

@MainActor
final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var cameraPosition: MapCameraPosition = .automatic
    @Published var markers: [MapMarkerModel] = []

    private let locationManager = CLLocationManager()
    private var currentCoordinate: CLLocationCoordinate2D?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func requestLocationAccess() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func addMarker(iconName: String) {
        guard let coordinate = currentCoordinate else { return }
        let marker = MapMarkerModel(id: UUID(), coordinate: coordinate, iconName: iconName)
        markers.append(marker)
    }

    // MARK: - CLLocationManagerDelegate

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }

        currentCoordinate = location.coordinate
        cameraPosition = .camera(MapCamera(centerCoordinate: location.coordinate,
                                           distance: 500,
                                           heading: 0,
                                           pitch: 0))
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse ||
           manager.authorizationStatus == .authorizedAlways {
            manager.startUpdatingLocation()
        }
    }
}

