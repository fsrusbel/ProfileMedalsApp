//
//  MedalRepositoryImp.swift
//  ProfileMedalsApp
//
//  Created by usuariolocal on 16/10/25.
//

import Foundation

final class MedalRepositoryImp: MedalRepository {
    
    private let localDataSource: MedalLocalDataSource

    init(localDataSource: MedalLocalDataSource) {
        self.localDataSource = localDataSource
    }

    func fetchAll() async throws -> [Medal] {
        let dtos = try await localDataSource.fetchAll()
        return dtos.map { $0.toDomain() }
    }

    func save(_ medal: Medal) async throws {
        try await localDataSource.save(.fromDomain(medal))
    }

    func saveAll(_ medals: [Medal]) async throws {
        let dtos = medals.map { MedalDTO.fromDomain($0) }
        try await localDataSource.saveAll(dtos)
    }

    func deleteAll() async throws {
        try await localDataSource.deleteAll()
    }

    func existsAny() async throws -> Bool {
        try await localDataSource.existsAny()
    }
    
}
