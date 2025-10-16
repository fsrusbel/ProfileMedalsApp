//
//  MedalsViewModel.swift
//  ProfileMedalsApp
//
//  Created by usuariolocal on 16/10/25.
//

import Foundation

@MainActor
final class MedalsViewModel: ObservableObject {
    
    @Published private(set) var medals: [MedalViewState] = []
    @Published var animateLevelUpMedalID: String?
    
    private let manageUseCase: ManageMedalsUseCase
    private let engine: PointsEngine
    private var eventsTask: Task<Void, Never>?
    
    init(manageUseCase: ManageMedalsUseCase, engine: PointsEngine) {
        self.manageUseCase = manageUseCase
        self.engine = engine
        Task { await load() }
        listenToEngine()
    }
    
    deinit { eventsTask?.cancel() }
    
    func load() async {
        do {
            let result = try await manageUseCase.fetchAll()
            medals = result.map { MedalViewState(domain: $0) }
        } catch {
            print("Error loading medals:", error)
        }
    }
    
    func resetAll() async {
        do {
            try await manageUseCase.resetAll()
            await load()
        } catch {
            print("Error resetting medals:", error)
        }
    }
    
    private func listenToEngine() {
        eventsTask = Task {
            for await event in engine.events {
                await handle(event)
            }
        }
    }
    
    private func handle(_ event: PointsEvent) async {
        switch event {
        case .pointsUpdated(let id, let points, let levelChanged, let newLevel):
            if let index = medals.firstIndex(where: { $0.id == id }) {
                medals[index].points = points
                if levelChanged {
                    medals[index].level = newLevel
                    medals[index].isMaxed = medals[index].level >= medals[index].maxLevel
                    animateLevelUpMedalID = id
                    Haptics.playLevelUp()
                    
                    Task {
                        try? await Task.sleep(nanoseconds: 1_200_000_000)
                        await MainActor.run { self.animateLevelUpMedalID = nil }
                    }
                }
            } else {
                await load()
            }
            
        case .medalMaxed(let id):
            if let i = medals.firstIndex(where: { $0.id == id }) {
                medals[i].isMaxed = true
            }
        }
    }
    
}
