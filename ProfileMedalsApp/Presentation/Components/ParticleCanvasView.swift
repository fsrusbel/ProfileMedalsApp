//
//  ParticleCanvasView.swift
//  ProfileMedalsApp
//
//  Created by usuariolocal on 16/10/25.
//

import SwiftUI
import Combine

struct ParticleCanvasView: View {
    @ObservedObject var emitter: ParticleEmitter
    
    var body: some View {
        GeometryReader { _ in
            Canvas { context, _ in
                for p in emitter.particles {
                    let rect = CGRect(x: p.pos.x, y: p.pos.y, width: p.size, height: p.size)
                    context.fill(Path(ellipseIn: rect), with: .color(p.color))
                }
            }
            .onReceive(Timer.publish(every: 1/60, on: .main, in: .common).autoconnect()) { _ in
                emitter.step(dt: 1/60)
            }
        }
    }
}
