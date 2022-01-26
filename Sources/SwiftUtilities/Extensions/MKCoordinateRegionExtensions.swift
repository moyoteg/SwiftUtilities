//
//  MKCoordinateRegionExtension.swift
//  Shared
//
//  Created by Moi Gutierrez on 6/29/21.
//

import MapKit

extension MKCoordinateRegion: Equatable {
    
    public static func == (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
        lhs.center == rhs.center &&
            lhs.span == rhs.span
    }
}

