//
//  MedalLocalDataSourceImp.swift
//  ProfileMedalsApp
//
//  Created by usuariolocal on 16/10/25.
//

//
//  MedalLocalDataSourceImp.swift
//  ProfileMedalsApp
//
//  Created by Rusbel FS on 16/10/25.
//

import Foundation
import SwiftData

final class MedalLocalDataSourceImp: MedalLocalDataSource {
    
    private let container: ModelContainer
    private let context: ModelContext

    init(container: ModelContainer) {
        self.container = container
        self.context = ModelContext(container)
    }

    func fetchAll() async throws -> [MedalDTO] {
        let entities: [MedalEntity] = try context.fetch(FetchDescriptor<MedalEntity>())
        return entities.map { $0.toDTO() }
    }

    func save(_ dto: MedalDTO) async throws {
        let descriptor = FetchDescriptor<MedalEntity>(
            predicate: #Predicate { $0.id == dto.id }
        )
        let results = try context.fetch(descriptor)
        if let existing = results.first {
            existing.update(from: dto)
        } else {
            context.insert(MedalEntity(from: dto))
        }
        try context.save()
    }

    func saveAll(_ dtos: [MedalDTO]) async throws {
        let existing: [MedalEntity] = try context.fetch(FetchDescriptor<MedalEntity>())
        var existingMap = Dictionary(uniqueKeysWithValues: existing.map { ($0.id, $0) })

        for dto in dtos {
            if let entity = existingMap[dto.id] {
                entity.update(from: dto)
            } else {
                context.insert(MedalEntity(from: dto))
            }
        }

        let keepIDs = Set(dtos.map { $0.id })
        for entity in existing where !keepIDs.contains(entity.id) {
            context.delete(entity)
        }

        try context.save()
    }

    func deleteAll() async throws {
        let all: [MedalEntity] = try context.fetch(FetchDescriptor<MedalEntity>())
        for e in all { context.delete(e) }
        try context.save()
    }

    func existsAny() async throws -> Bool {
        try context.fetchCount(FetchDescriptor<MedalEntity>()) > 0
    }
    
}
