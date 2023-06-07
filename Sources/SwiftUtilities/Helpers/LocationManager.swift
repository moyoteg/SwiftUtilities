//
//  File.swift
//  
//
//  Created by Moi Gutierrez on 3/26/20.
//

import SwiftUI
import CoreLocation

public class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    
    @Published public var authorizationStatus: CLAuthorizationStatus = .notDetermined
    @Published public var currentLocation: CLLocation?
    @Published public var locationHistory: [CLLocation] = []
    @Published public var heading: CLHeading?
    @Published public var rangingBeacons: [CLBeacon] = []
    @Published public var monitoringRegions: [CLRegion] = []
    @Published public var visitHistory: [CLVisit] = []
    
    @Published public var didStartMonitoringFor: CLRegion?
    @Published public var monitoringDidFailFor: CLRegion?
    @Published public var didDetermineState: CLRegionState?
    @Published public var didRange: [CLBeacon]?
    @Published public var didFailRangingFor: CLBeaconIdentityConstraint?
    @Published public var didPauseLocationUpdates: CLLocationManager?
    @Published public var didResumeLocationUpdates: CLLocationManager?
    
    public override init() {
        super.init()
        
        locationManager.delegate = self
    }
    
    public func requestLocationAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    public func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    public func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    public func startUpdatingHeading() {
        locationManager.startUpdatingHeading()
    }
    
    public func stopUpdatingHeading() {
        locationManager.stopUpdatingHeading()
    }
    
    public func startRangingBeacons(in region: CLBeaconRegion) {
        locationManager.startRangingBeacons(satisfying: region.beaconIdentityConstraint)
    }
    
    public func stopRangingBeacons(in region: CLBeaconRegion) {
        locationManager.stopRangingBeacons(satisfying: region.beaconIdentityConstraint)
    }
    
    public func startMonitoring(for region: CLRegion) {
        locationManager.startMonitoring(for: region)
    }
    
    public func stopMonitoring(for region: CLRegion) {
        locationManager.stopMonitoring(for: region)
    }
    
    public func startMonitoringVisits() {
        locationManager.startMonitoringVisits()
    }
    
    public func stopMonitoringVisits() {
        locationManager.stopMonitoringVisits()
    }
    
    // MARK: - CLLocationManagerDelegate
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authorizationStatus = status
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation = location
        locationHistory.append(location)
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error.localizedDescription)")
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        heading = newHeading
    }
    
    public func locationManagerShouldDisplayHeadingCalibration(_ manager: CLLocationManager) -> Bool {
        return true
    }
    
    public func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        rangingBeacons = beacons
    }
    
    public func locationManager(_ manager: CLLocationManager, rangingBeaconsDidFailFor region: CLBeaconRegion, withError error: Error) {
        print("Ranging beacons failed with error: \(error.localizedDescription)")
    }
    
    public func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        monitoringRegions.append(region)
    }
    
    public func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        if let index = monitoringRegions.firstIndex(of: region) {
            monitoringRegions.remove(at: index)
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {
        visitHistory.append(visit)
    }
    
    // MARK: - CLLocationManagerDelegate
    
    public func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        // Handle start of region monitoring
        self.didStartMonitoringFor = didStartMonitoringFor
    }
    
    public func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        // Handle region monitoring failure
        self.monitoringDidFailFor = monitoringDidFailFor
    }
    
    public func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        // Handle region state determination
        self.didDetermineState = didDetermineState
    }
    
    public func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
        // Handle ranging beacons with constraints
        self.didRange = didRange
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailRangingFor beaconConstraint: CLBeaconIdentityConstraint, error: Error) {
        // Handle ranging beacons failure with constraints
        self.didFailRangingFor = didFailRangingFor
    }
    
    public func locationManager(_ manager: CLLocationManager, didPauseLocationUpdates locationUpdates: CLLocationManager) {
        // Handle location updates pause
        self.didPauseLocationUpdates = didPauseLocationUpdates
    }
    
    public func locationManager(_ manager: CLLocationManager, didResumeLocationUpdates locationUpdates: CLLocationManager) {
        // Handle location updates resume
        self.didResumeLocationUpdates = didResumeLocationUpdates
    }
}
