//
//  ConfettiView.swift
//  ProfileMedalsApp
//
//  Created by usuariolocal on 16/10/25.
//

import SwiftUI

struct ConfettiView: View {
    @StateObject var emitter = ParticleEmitter()

    var body: some View {
        GeometryReader { geo in
            ParticleCanvasView(emitter: emitter)
                .onAppear {
                    emitter.emit(in: CGRect(x: 0, y: 0, width: geo.size.width, height: geo.size.height), count: 30)
                }
        }
    }
}
