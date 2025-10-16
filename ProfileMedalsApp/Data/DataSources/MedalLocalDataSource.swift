//
//  MedalLocalDataSource.swift
//  ProfileMedalsApp
//
//  Created by usuariolocal on 16/10/25.
//

protocol MedalLocalDataSource {
    func fetchAll() async throws -> [MedalDTO]
    func save(_ dto: MedalDTO) async throws
    func saveAll(_ dtos: [MedalDTO]) async throws
    func deleteAll() async throws
    func existsAny() async throws -> Bool
}
