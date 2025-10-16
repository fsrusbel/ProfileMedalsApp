//
//  MedalCardView.swift
//  ProfileMedalsApp
//
//  Created by usuariolocal on 16/10/25.
//

import SwiftUI

struct MedalCardView: View {
    
    var viewState: MedalViewState
    var animate: Bool
    
    @StateObject private var emitter = ParticleEmitter()
    
    var body: some View {
        ZStack {
            VStack(spacing: 12) {
                ZStack {
                    Circle()
                        .fill(Color(hex: viewState.backgroundColorHex) ?? Color.gray)
                        .frame(width: 72, height: 72)
                        .shadow(radius: 4)
                    Image(systemName: viewState.iconName)
                        .font(.system(size: 30))
                        .foregroundStyle(.white)
                        .scaleEffect(animate ? 1.2 : 1.0)
                        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: animate)
                }
                
                Text(viewState.name)
                    .font(.subheadline)
                    .bold()
                    .multilineTextAlignment(.center)
                
                ProgressView(value: viewState.progress)
                    .tint(Color(hex: viewState.progressColorHex) ?? .blue)
                    .frame(height: 8)
                    .padding(.horizontal, 8)
                
                HStack {
                    Text("LVL \(viewState.level)")
                        .font(.caption2)
                        .bold()
                        .padding(6)
                        .background(.ultraThinMaterial)
                        .cornerRadius(8)
                    Spacer()
                    Text("\(viewState.points)/100")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal, 8)
            }
            .padding()
            .background(.regularMaterial)
            .cornerRadius(14)
            .onChange(of: animate) { new in
                if new {
                    emitter.emit(in: CGRect(x: 0, y: 0, width: 160, height: 200))
                }
            }
            
            ParticleCanvasView(emitter: emitter).allowsHitTesting(false)
        }
    }
    
}
