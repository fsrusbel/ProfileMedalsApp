//
//  MedalRepository.swift
//  ProfileMedalsApp
//
//  Created by usuariolocal on 16/10/25.
//


protocol MedalRepository {
    func fetchAll() async throws -> [Medal]
    func save(_ medal: Medal) async throws
    func saveAll(_ medals: [Medal]) async throws
    func deleteAll() async throws
    func existsAny() async throws -> Bool
}
