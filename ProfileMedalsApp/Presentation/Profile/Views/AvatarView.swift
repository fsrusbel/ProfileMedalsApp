//
//  AvatarView.swift
//  ProfileMedalsApp
//
//  Created by usuariolocal on 16/10/25.
//

import SwiftUI

struct AvatarView: View {
    
    let onTap: () -> Void
    
    var body: some View {
        Image(systemName: "person.crop.circle.fill")
            .resizable()
            .frame(width: 84, height: 84)
            .scaledToFit()
            .onTapGesture {
                Haptics.playTap()
                onTap()
            }
            .padding()
    }
    
}
