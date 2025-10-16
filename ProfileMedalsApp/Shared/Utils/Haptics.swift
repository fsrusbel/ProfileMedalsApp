//
//  Haptics.swift
//  ProfileMedalsApp
//
//  Created by usuariolocal on 16/10/25.
//

import UIKit

enum Haptics {
    
    static func playLevelUp() {
        let g = UINotificationFeedbackGenerator()
        g.prepare()
        g.notificationOccurred(.success)
    }
    
    static func playTap() {
        let g = UIImpactFeedbackGenerator(style: .light)
        g.impactOccurred()
    }
    
}
