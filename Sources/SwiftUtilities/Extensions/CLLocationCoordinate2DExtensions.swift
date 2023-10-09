//
//  CLLocationCoordinate2D.swift
//  Shared
//
//  Created by Moi Gutierrez on 6/29/21.
//

import MapKit

extension CLLocationCoordinate2D: Equatable {
    
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude &&
            lhs.longitude == rhs.longitude
    }
}

extension CLLocationCoordinate2D {
    /// Returns distance from coordianate in meters.
    /// - Parameter from: coordinate which will be used as end point.
    /// - Returns: Returns distance in meters.
    public func distance(from: CLLocationCoordinate2D) -> CLLocationDistance {
        let from = CLLocation(latitude: from.latitude, longitude: from.longitude)
        let to = CLLocation(latitude: self.latitude, longitude: self.longitude)
        return from.distance(from: to)
    }
}

extension CLLocationCoordinate2D: Identifiable {
    public var id: String {
        "\(latitude)-\(longitude)"
    }
}
