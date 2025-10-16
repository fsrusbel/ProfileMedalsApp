//
//  ManageMedalsUseCase.swift
//  ProfileMedalsApp
//
//  Created by usuariolocal on 16/10/25.
//

protocol ManageMedalsUseCase {
    func fetchAll() async throws -> [Medal]
    func save(_ medal: Medal) async throws
    func saveAll(_ medals: [Medal]) async throws
    func resetAll() async throws
    func observe() -> AsyncStream<Medal>
}
