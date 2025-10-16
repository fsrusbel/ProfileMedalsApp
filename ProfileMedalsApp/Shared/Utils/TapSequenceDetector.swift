//
//  TapSequenceDetector.swift
//  ProfileMedalsApp
//
//  Created by usuariolocal on 16/10/25.
//

import Foundation

final class TapSequenceDetector {
    
    private var count = 0
    private var lastTap: Date?
    private let limitSeconds: TimeInterval
    private let threshold: Int
    
    init(threshold: Int = 5, limitSeconds: TimeInterval = 1.0) {
        self.threshold = threshold
        self.limitSeconds = limitSeconds
    }
    
    func registerTap() -> Bool {
        let now = Date()
        if let last = lastTap, now.timeIntervalSince(last) > limitSeconds {
            count = 0
        }
        lastTap = now
        count += 1
        if count >= threshold {
            count = 0
            lastTap = nil
            return true
        }
        return false
    }
    
}
