//
//  MapMarkerModel.swift
//  PeepORpoop
//
//  Created by Денис Меркотун on 09.04.2025.
//

import Foundation
import CoreLocation

struct MapMarkerModel: Identifiable {
    let id: UUID
    let coordinate: CLLocationCoordinate2D
    let iconName: String
}

