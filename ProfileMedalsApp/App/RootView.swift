//
//  RootView.swift
//  ProfileMedalsApp
//
//  Created by usuariolocal on 16/10/25.
//

import SwiftUI

struct RootView: View {
    @ObservedObject var di: AppDIContainer

    var body: some View {
        let medalsVM = di.makeMedalsViewModel()
        let profileVM = di.makeProfileViewModel(medalsViewModel: medalsVM)

        ProfileView(viewModel: profileVM)
            .task {
                try? await di.seedLoader.seedIfNeeded()
                await di.pointsEngine.start()
            }
    }
}

