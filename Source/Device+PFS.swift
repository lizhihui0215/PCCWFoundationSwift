//
//  Device+PFS.swift
//  PCCWFoundationSwift
//
//  Created by 李智慧 on 21/04/2017.
//
//

import DeviceKit
import KeychainAccess

public let keychain = Keychain()

public let device = Device()

extension Device {
    public var appVersion: String {
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }
    
    public var appName: String{
        return Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
    }
    
    public var screenSize: CGSize {
        return UIScreen.main.bounds.size
    }
    
    public var uuid: String {
        
        if let uuid = keychain["uuid"] {
            return uuid
        }
        
        let uuid = UUID().uuidString
        
        keychain["uuid"] = uuid
        
        return uuid
    }
    
    // Return IP address of WiFi interface (en0) as a String, or `nil`
    public func getWiFiAddress() -> String? {
        var address : String?
        
        // Get list of all interfaces on the local machine:
        var ifaddr : UnsafeMutablePointer<ifaddrs> = nil
        if getifaddrs(&ifaddr) == 0 {
            
            // For each interface ...
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr.memory.ifa_next }
                
                let interface = ptr.memory
                
                // Check for IPv4 or IPv6 interface:
                let addrFamily = interface.ifa_addr.memory.sa_family
                if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                    
                    // Check interface name:
                    if let name = String.fromCString(interface.ifa_name), name == "en0" {
                        
                        // Convert interface address to a human readable string:
                        var hostname = [CChar](count: Int(NI_MAXHOST), repeatedValue: 0)
                        getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.memory.sa_len),
                                    &hostname, socklen_t(hostname.count),
                                    nil, socklen_t(0), NI_NUMERICHOST)
                        address = String.fromCString(hostname)
                    }
                }
            }
            freeifaddrs(ifaddr)
        }
        
        return address
    }
}
