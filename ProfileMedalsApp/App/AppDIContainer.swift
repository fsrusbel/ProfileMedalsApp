//
//  AppDIContainer.swift
//  ProfileMedalsApp
//
//  Created by usuariolocal on 16/10/25.
//

import Foundation
import SwiftData

@MainActor
final class AppDIContainer: ObservableObject {
    
    let container: ModelContainer

    // Data
    lazy var medalLocalDataSource: MedalLocalDataSource = {
        MedalLocalDataSourceImp(container: container)
    }()

    lazy var medalRepository: MedalRepository = {
        MedalRepositoryImp(localDataSource: medalLocalDataSource)
    }()

    // Use Case
    lazy var manageMedalsUseCase: ManageMedalsUseCase = {
        ManageMedalsUseCaseImp(repository: medalRepository)
    }()

    // Engine
    lazy var pointsEngine: PointsEngine = {
        PointsEngineImp(repository: medalRepository)
    }()

    // Seeder
    lazy var seedLoader: SeedLoader = {
        SeedLoaderImp(container: container)
    }()

    init(container: ModelContainer) {
        self.container = container
    }

    // Presentation factories
    func makeMedalsViewModel() -> MedalsViewModel {
        MedalsViewModel(manageUseCase: manageMedalsUseCase, engine: pointsEngine)
    }

    func makeProfileViewModel(medalsViewModel: MedalsViewModel) -> ProfileViewModel {
        ProfileViewModel(medalsViewModel: medalsViewModel, engine: pointsEngine, seedLoader: seedLoader)
    }
    
}

