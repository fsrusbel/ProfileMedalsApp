//
//  ManageMedalsUseCaseImp.swift
//  ProfileMedalsApp
//
//  Created by usuariolocal on 16/10/25.
//

final class ManageMedalsUseCaseImp: ManageMedalsUseCase {
    
    private let repository: MedalRepository
    
    init(repository: MedalRepository) {
        self.repository = repository
    }
    
    func fetchAll() async throws -> [Medal] { try await repository.fetchAll() }
    func save(_ medal: Medal) async throws { try await repository.save(medal) }
    func saveAll(_ medals: [Medal]) async throws { try await repository.saveAll(medals) }
    
    func resetAll() async throws {
        let medals = try await repository.fetchAll()
        try await repository.saveAll(medals.map { $0.reset() })
    }
    
    func observe() -> AsyncStream<Medal> {
        AsyncStream { continuation in
            let task = Task {
                while !Task.isCancelled {
                    do {
                        let medals = try await repository.fetchAll()
                        for m in medals { continuation.yield(m) }
                        try await Task.sleep(nanoseconds: 1_000_000_000)
                    } catch {
                        try? await Task.sleep(nanoseconds: 1_000_000_000)
                    }
                }
                continuation.finish()
            }
            continuation.onTermination = { _ in task.cancel() }
        }
    }
    
}
