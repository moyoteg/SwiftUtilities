//
//  Reachability.swift
//  SwiftUtilities
//
//  Created by Moi Gutierrez on 7/3/22.
//

import Foundation

import Foundation
import SystemConfiguration

public class NetworkReachability: ObservableObject {
    
    @Published private(set) var reachable: Bool = false
    
    private let reachability = SCNetworkReachabilityCreateWithName(nil, "www.apple.com")

    public init() {
        self.reachable = updateConnectionStatus()
    }

    private func isNetworkReachable(with flags: SCNetworkReachabilityFlags) -> Bool {
        
        let isReachable = flags.contains(.reachable)
        
        let connectionRequired = flags.contains(.connectionRequired)
        
        let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        
        let canConnectWithoutIntervention = canConnectAutomatically && !flags.contains(.interventionRequired)
        
        return isReachable && (!connectionRequired || canConnectWithoutIntervention)
    }

    public func updateConnectionStatus() -> Bool {
        
        var flags = SCNetworkReachabilityFlags()
        
        SCNetworkReachabilityGetFlags(reachability!, &flags)

        return isNetworkReachable(with: flags)
    }
}
