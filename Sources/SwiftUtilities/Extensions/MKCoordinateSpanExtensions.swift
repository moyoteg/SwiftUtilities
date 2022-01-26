//
//  MKCoordinateSpanExtension.swift
//  Shared
//
//  Created by Moi Gutierrez on 6/29/21.
//

import MapKit

extension MKCoordinateSpan: Equatable {
    
    public static func == (lhs: MKCoordinateSpan, rhs: MKCoordinateSpan) -> Bool {
        lhs.latitudeDelta == rhs.latitudeDelta &&
            lhs.longitudeDelta == rhs.longitudeDelta
    }
}

