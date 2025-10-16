//
//  SeedLoader.swift
//  ProfileMedalsApp
//
//  Created by usuariolocal on 16/10/25.
//

import Foundation
import SwiftData

protocol SeedLoader {
    func seedIfNeeded() async throws
    func clearAllAndSeed() async throws
}

final class SeedLoaderImp: SeedLoader {
    
    private let container: ModelContainer
    private let context: ModelContext

    init(container: ModelContainer) {
        self.container = container
        self.context = ModelContext(container)
    }

    func seedIfNeeded() async throws {
        let count = try context.fetchCount(FetchDescriptor<MedalEntity>())
        guard count == 0 else {
            print("Datos existentes — no se requiere seed.")
            return
        }
        try await seedFromJSON()
    }

    func clearAllAndSeed() async throws {
        print("Limpiando datos y recargando seed...")
        let all: [MedalEntity] = try context.fetch(FetchDescriptor<MedalEntity>())
        for e in all { context.delete(e) }
        try context.save()
        try await seedFromJSON()
    }

    private func seedFromJSON() async throws {
        guard let url = Bundle.main.url(forResource: "seed_medals", withExtension: "json") else {
            throw NSError(domain: "SeedLoader", code: 404, userInfo: [NSLocalizedDescriptionKey: "Archivo JSON no encontrado en el bundle"])
        }

        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let dtos = try decoder.decode([MedalDTO].self, from: data)

        for dto in dtos {
            let entity = MedalEntity(from: dto)
            context.insert(entity)
        }

        try context.save()
        print("Seed completado con \(dtos.count) medallas.")
    }
    
}
