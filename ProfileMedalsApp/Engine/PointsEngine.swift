//
//  PointsEngine.swift
//  ProfileMedalsApp
//
//  Created by usuariolocal on 16/10/25.
//

import Foundation

enum PointsEvent: Sendable {
    case pointsUpdated(medalId: String, points: Int, levelChanged: Bool, newLevel: Int)
    case medalMaxed(medalId: String)
}


protocol PointsEngine {
    var events: AsyncStream<PointsEvent> { get }
    func start() async
    func pause() async
    func resume() async
    func stop() async
    func resetAll() async
}
