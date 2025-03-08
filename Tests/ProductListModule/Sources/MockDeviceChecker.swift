//
//  MockDeviceChecker.swift
//  OunassCase
//
//  Created by Yasin Akbas on 8.03.2025.
//

@testable import CommonKit

final class MockDeviceChecker: DeviceCheckerInterface {
    var invokedIsPotraitGetter = false
    var invokedIsPotraitGetterCount = 0
    var stubbedIsPotrait: Bool! = false

    var isPotrait: Bool {
        invokedIsPotraitGetter = true
        invokedIsPotraitGetterCount += 1
        return stubbedIsPotrait
    }
}
