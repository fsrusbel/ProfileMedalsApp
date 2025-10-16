//
//  ParticleEmitter.swift
//  ProfileMedalsApp
//
//  Created by usuariolocal on 16/10/25.
//

import SwiftUI

final class ParticleEmitter: ObservableObject {
    
    @Published var particles: [Particle] = []
    
    func emit(in rect: CGRect, count: Int = 20) {
        particles.removeAll()
        for _ in 0..<count {
            let x = CGFloat.random(in: rect.minX...rect.maxX)
            let y = rect.minY
            let size = CGFloat.random(in: 6...14)
            let p = Particle(
                pos: CGPoint(x: x, y: y),
                velocity: .init(dx: CGFloat.random(in: -80...80), dy: CGFloat.random(in: 120...360)),
                acceleration: .init(dx: 0, dy: 80),
                rotation: Double.random(in: 0...360),
                angularVelocity: Double.random(in: -6...6),
                size: size,
                color: Color(hue: Double.random(in: 0...1), saturation: 0.8, brightness: 0.9),
                life: Double.random(in: 1.0...1.6)
            )
            particles.append(p)
        }
    }
    
    func step(dt: Double) {
        var newParticles: [Particle] = []
        for var p in particles {
            p.velocity.dx += p.acceleration.dx * CGFloat(dt)
            p.velocity.dy += p.acceleration.dy * CGFloat(dt)
            p.pos.x += p.velocity.dx * CGFloat(dt)
            p.pos.y += p.velocity.dy * CGFloat(dt)
            p.rotation += p.angularVelocity * dt
            p.life -= dt
            if p.life > 0 { newParticles.append(p) }
        }
        DispatchQueue.main.async { self.particles = newParticles }
    }
    
}
