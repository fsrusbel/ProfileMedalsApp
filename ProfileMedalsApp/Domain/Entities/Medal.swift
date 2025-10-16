//
//  Medal.swift
//  ProfileMedalsApp
//
//  Created by usuariolocal on 16/10/25.
//

import Foundation

struct Medal: Identifiable, Equatable, Sendable {
    let id: String
    var name: String
    var description: String
    var iconName: String
    var level: Int
    var points: Int
    var maxLevel: Int
    var animationType: String
    var backgroundColorHex: String
    var progressColorHex: String
    
    var isMaxed: Bool { level >= maxLevel }
    
    func reset() -> Medal {
        var c = self
        c.level = 1
        c.points = 0
        return c
    }
    
}
