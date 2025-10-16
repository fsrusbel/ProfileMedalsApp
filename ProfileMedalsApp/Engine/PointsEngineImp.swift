//
//  PointsEngineImp.swift
//  ProfileMedalsApp
//
//  Created by usuariolocal on 16/10/25.
//

import Foundation

actor PointsEngineImp: PointsEngine {
    
    private let repository: MedalRepository
    private var workers: [String: Task<Void, Never>] = [:]
    private var continuationRef: AsyncStream<PointsEvent>.Continuation?
    public let events: AsyncStream<PointsEvent>

    init(repository: MedalRepository) {
        self.repository = repository
        var cont: AsyncStream<PointsEvent>.Continuation?
        self.events = AsyncStream { cont = $0 }
        self.continuationRef = cont
    }

    func start() async {
        await stop()
        do {
            let medals = try await repository.fetchAll()
            for m in medals where !m.isMaxed { spawnWorker(for: m) }
        } catch { print("Engine start error:", error) }
    }

    func pause() async {
        for (_, t) in workers { t.cancel() }
        workers.removeAll()
    }

    func resume() async { await start() }
    func stop() async { await pause() }

    func resetAll() async {
        await stop()
        do {
            let medals = try await repository.fetchAll().map { $0.reset() }
            try await repository.saveAll(medals)
            for m in medals {
                continuationRef?.yield(.pointsUpdated(medalId: m.id, points: m.points, levelChanged: true, newLevel: m.level))
            }
            await start()
        } catch { print("resetAll error:", error) }
    }

    private func spawnWorker(for initial: Medal) {
        workers[initial.id]?.cancel()
        let task = Task {
            var medal = initial
            while !Task.isCancelled && !medal.isMaxed {
                try? await Task.sleep(nanoseconds: UInt64.random(in: 200_000_000...400_000_000))
                medal.points += Int.random(in: 10...25)
                var leveled = false
                if medal.points >= 100 {
                    medal.points = 0
                    medal.level += 1
                    if medal.level > medal.maxLevel { medal.level = medal.maxLevel }
                    leveled = true
                }
                try? await repository.save(medal)
                continuationRef?.yield(.pointsUpdated(medalId: medal.id, points: medal.points, levelChanged: leveled, newLevel: medal.level))
                if medal.isMaxed {
                    continuationRef?.yield(.medalMaxed(medalId: medal.id))
                    break
                }
            }
        }
        workers[initial.id] = task
    }
    
}
