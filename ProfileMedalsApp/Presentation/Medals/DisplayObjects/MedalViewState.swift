//
//  MedalViewState.swift
//  ProfileMedalsApp
//
//  Created by usuariolocal on 16/10/25.
//

struct MedalViewState: Identifiable, Equatable {
    let id: String
    var name: String
    var description: String
    var iconName: String
    var level: Int
    var points: Int
    var maxLevel: Int
    var backgroundColorHex: String
    var progressColorHex: String
    var isMaxed: Bool
    
    var progress: Double { Double(points) / 100.0 }
    
    init(domain: Medal) {
        self.id = domain.id
        self.name = domain.name
        self.description = domain.description
        self.iconName = domain.iconName
        self.level = domain.level
        self.points = domain.points
        self.maxLevel = domain.maxLevel
        self.backgroundColorHex = domain.backgroundColorHex
        self.progressColorHex = domain.progressColorHex
        self.isMaxed = domain.isMaxed
    }
}
