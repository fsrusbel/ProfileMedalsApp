//
//  Particle.swift
//  ProfileMedalsApp
//
//  Created by usuariolocal on 16/10/25.
//

import SwiftUI

struct Particle: Identifiable {
    let id = UUID()
    var pos: CGPoint
    var velocity: CGVector
    var acceleration: CGVector = .init(dx: 0, dy: 80)
    var rotation: Double
    var angularVelocity: Double
    var size: CGFloat
    var color: Color
    var life: Double
}
