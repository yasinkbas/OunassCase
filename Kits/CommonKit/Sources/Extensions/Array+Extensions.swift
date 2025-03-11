//
//  Array+Extensions.swift
//  OunassCase
//
//  Created by Yasin Akbas on 11.03.2025.
//

public extension Array {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
