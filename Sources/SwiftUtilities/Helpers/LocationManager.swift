//
//  File.swift
//  
//
//  Created by Moi Gutierrez on 3/26/20.
//

import SwiftUI
import CoreLocation


class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    @Published var currentLocation: CLLocation?
    @Published var heading: CLHeading?
    @Published var rangingBeacons: [CLBeacon] = []
    @Published var monitoringRegions: [CLRegion] = []
    @Published var didVisit: CLVisit?
    
    override init() {
        super.init()
        
        locationManager.delegate = self
    }
    
    func requestLocationAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func startUpdatingHeading() {
        locationManager.startUpdatingHeading()
    }
    
    func stopUpdatingHeading() {
        locationManager.stopUpdatingHeading()
    }
    
    func startRangingBeacons(in region: CLBeaconRegion) {
        locationManager.startRangingBeacons(satisfying: region.beaconIdentityConstraint)
    }
    
    func stopRangingBeacons(in region: CLBeaconRegion) {
        locationManager.stopRangingBeacons(satisfying: region.beaconIdentityConstraint)
    }
    
    func startMonitoring(for region: CLRegion) {
        locationManager.startMonitoring(for: region)
    }
    
    func stopMonitoring(for region: CLRegion) {
        locationManager.stopMonitoring(for: region)
    }
    
    func startMonitoringVisits() {
        locationManager.startMonitoringVisits()
    }
    
    func stopMonitoringVisits() {
        locationManager.stopMonitoringVisits()
    }
    
    // MARK: - CLLocationManagerDelegate
    
    internal func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authorizationStatus = status
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation = location
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        heading = newHeading
    }
    
    func locationManagerShouldDisplayHeadingCalibration(_ manager: CLLocationManager) -> Bool {
        return true
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        rangingBeacons = beacons
    }
    
    func locationManager(_ manager: CLLocationManager, rangingBeaconsDidFailFor region: CLBeaconRegion, withError error: Error) {
        print("Ranging beacons failed with error: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        monitoringRegions.append(region)
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        if let index = monitoringRegions.firstIndex(of: region) {
            monitoringRegions.remove(at: index)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {
        didVisit = visit
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        // Handle start of region monitoring
    }
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        // Handle region monitoring failure
    }
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        // Handle region state determination
    }
    
    func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
        // Handle ranging beacons with constraints
    }
    
    func locationManager(_ manager: CLLocationManager, didFailRangingFor beaconConstraint: CLBeaconIdentityConstraint, error: Error) {
        // Handle ranging beacons failure with constraints
    }
    
    func locationManager(_ manager: CLLocationManager, didPauseLocationUpdates locationUpdates: CLLocationManager) {
        // Handle location updates pause
    }
    
    func locationManager(_ manager: CLLocationManager, didResumeLocationUpdates locationUpdates: CLLocationManager) {
        // Handle location updates resume
    }
}

struct LocationManagerView: View {
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        VStack {
            Text("Authorization Status: \(locationManager.authorizationStatus.rawValue)")
            
            if let location = locationManager.currentLocation {
                Text("Latitude: \(location.coordinate.latitude)")
                Text("Longitude: \(location.coordinate.longitude)")
            }
            
            if let heading = locationManager.heading {
                Text("Heading: \(heading.trueHeading)")
            }
            
            Text("Ranging Beacons:")
            ForEach(locationManager.rangingBeacons, id: \.self) { beacon in
                Text("UUID: \(beacon.uuid)")
                Text("Major: \(beacon.major)")
                Text("Minor: \(beacon.minor)")
                Text("Accuracy: \(beacon.accuracy)")
            }
            
            Text("Monitoring Regions:")
            ForEach(locationManager.monitoringRegions, id: \.self) { region in
                Text("Identifier: \(region.identifier)")
            }
            
            if let visit = locationManager.didVisit {
                Text("Did Visit:")
                Text("Arrival Date: \(visit.arrivalDate)")
                Text("Departure Date: \(visit.departureDate)")
            }
        }
        .onAppear {
            locationManager.requestLocationAuthorization()
            locationManager.startUpdatingLocation()
            locationManager.startUpdatingHeading()
            
            let proximityUUID = UUID()
            let region = CLBeaconRegion(uuid: proximityUUID, identifier: "SampleRegion")
            locationManager.startRangingBeacons(in: region)
            
            let circularRegion = CLCircularRegion(center: CLLocationCoordinate2D(latitude: 37.3318, longitude: -122.0312), radius: 500, identifier: "SampleCircularRegion")
            locationManager.startMonitoring(for: circularRegion)
            
            locationManager.startMonitoringVisits()
        }
        .onDisappear {
            locationManager.stopUpdatingLocation()
            locationManager.stopUpdatingHeading()
            
            let proximityUUID = UUID()
            let region = CLBeaconRegion(uuid: proximityUUID, identifier: "SampleRegion")
            locationManager.stopRangingBeacons(in: region)
            
            let circularRegion = CLCircularRegion(center: CLLocationCoordinate2D(latitude: 37.3318, longitude: -122.0312), radius: 500, identifier: "SampleCircularRegion")
            locationManager.stopMonitoring(for: circularRegion)
            
            locationManager.stopMonitoringVisits()
        }
    }
}

struct LocationManagerView_Previews: PreviewProvider {
    static var previews: some View {
        LocationManagerView()
    }
}
