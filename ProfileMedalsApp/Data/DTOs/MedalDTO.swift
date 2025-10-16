//
//  MedalDTO.swift
//  ProfileMedalsApp
//
//  Created by usuariolocal on 16/10/25.
//

import Foundation

struct MedalDTO: Codable, Sendable {
    let id: String
    let name: String
    let description: String
    let iconName: String
    let level: Int
    let points: Int
    let maxLevel: Int
    let animationType: String
    let backgroundColorHex: String
    let progressColorHex: String

    enum CodingKeys: String, CodingKey {
        case id, name, description
        case iconName = "icon"
        case level, points, maxLevel, animationType
        case backgroundColorHex = "backgroundColor"
        case progressColorHex = "progressColor"
    }
}

extension MedalDTO {
    
    func toDomain() -> Medal {
        Medal(
            id: id,
            name: name,
            description: description,
            iconName: iconName,
            level: level,
            points: points,
            maxLevel: maxLevel,
            animationType: animationType,
            backgroundColorHex: backgroundColorHex,
            progressColorHex: progressColorHex
        )
    }

    static func fromDomain(_ m: Medal) -> MedalDTO {
        MedalDTO(
            id: m.id,
            name: m.name,
            description: m.description,
            iconName: m.iconName,
            level: m.level,
            points: m.points,
            maxLevel: m.maxLevel,
            animationType: m.animationType,
            backgroundColorHex: m.backgroundColorHex,
            progressColorHex: m.progressColorHex
        )
    }
    
}
