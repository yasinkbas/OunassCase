//
//  DeviceChecker.swift
//  OunassCase
//
//  Created by Yasin Akbas on 7.03.2025.
//

import UIKit

public protocol DeviceCheckerInterface: AnyObject {
    var isPotrait: Bool { get }
}

public class DeviceChecker: DeviceCheckerInterface {
    public var isPotrait: Bool {
        return UIDevice.current.orientation.isPortrait || UIDevice.current.orientation == .unknown
    }
    
    public init() { }
}
