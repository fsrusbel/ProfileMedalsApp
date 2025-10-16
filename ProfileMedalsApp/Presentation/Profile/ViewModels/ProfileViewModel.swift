//
//  ProfileViewModel.swift
//  ProfileMedalsApp
//
//  Created by usuariolocal on 16/10/25.
//

import Foundation

@MainActor
final class ProfileViewModel: ObservableObject {
    
    let medalsViewModel: MedalsViewModel
    private let engine: PointsEngine
    private let seedLoader: SeedLoader
    private let detector = TapSequenceDetector(threshold: 5, limitSeconds: 1.0)
    
    init(medalsViewModel: MedalsViewModel, engine: PointsEngine, seedLoader: SeedLoader) {
        self.medalsViewModel = medalsViewModel
        self.engine = engine
        self.seedLoader = seedLoader
    }
    
    func avatarTapped() {
        let triggered = detector.registerTap()
        if triggered {
            Task {
                print("Reset triggered by 5 taps")
                try? await seedLoader.clearAllAndSeed()
                await medalsViewModel.load()
                await engine.start()
            }
        }
    }
    
}
