//
//  MedalEntity.swift
//  ProfileMedalsApp
//
//  Created by usuariolocal on 16/10/25.
//
//
//  MedalEntity.swift
//  ProfileMedalsApp
//
//  Created by usuariolocal on 16/10/25.
//

import Foundation
import SwiftData

@Model
final class MedalEntity {
    @Attribute(.unique) var id: String
    var name: String
    var desc: String
    var iconName: String
    var level: Int
    var points: Int
    var maxLevel: Int
    var animationType: String
    var backgroundColorHex: String
    var progressColorHex: String
    var createdAt: Date
    var updatedAt: Date

    init(
        id: String = UUID().uuidString,
        name: String,
        desc: String,
        iconName: String,
        level: Int,
        points: Int,
        maxLevel: Int,
        animationType: String,
        backgroundColorHex: String,
        progressColorHex: String,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.name = name
        self.desc = desc
        self.iconName = iconName
        self.level = level
        self.points = points
        self.maxLevel = maxLevel
        self.animationType = animationType
        self.backgroundColorHex = backgroundColorHex
        self.progressColorHex = progressColorHex
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    convenience init(from dto: MedalDTO) {
        self.init(
            id: dto.id,
            name: dto.name,
            desc: dto.description,
            iconName: dto.iconName,
            level: dto.level,
            points: dto.points,
            maxLevel: dto.maxLevel,
            animationType: dto.animationType,
            backgroundColorHex: dto.backgroundColorHex,
            progressColorHex: dto.progressColorHex,
            createdAt: Date(),
            updatedAt: Date()
        )
    }

    func update(from dto: MedalDTO) {
        name = dto.name
        desc = dto.description
        iconName = dto.iconName
        level = dto.level
        points = dto.points
        maxLevel = dto.maxLevel
        animationType = dto.animationType
        backgroundColorHex = dto.backgroundColorHex
        progressColorHex = dto.progressColorHex
        updatedAt = Date()
    }

    func toDTO() -> MedalDTO {
        MedalDTO(
            id: id,
            name: name,
            description: desc,
            iconName: iconName,
            level: level,
            points: points,
            maxLevel: maxLevel,
            animationType: animationType,
            backgroundColorHex: backgroundColorHex,
            progressColorHex: progressColorHex
        )
    }
    
}
