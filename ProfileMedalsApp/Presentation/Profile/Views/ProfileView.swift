//
//  ProfileView.swift
//  ProfileMedalsApp
//
//  Created by usuariolocal on 16/10/25.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HStack(alignment: .center) {
                    AvatarView { viewModel.avatarTapped() }
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Rusbel Flores")
                            .font(.title2.bold())
                        Text("iOS Developer")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                
                ModulesView(medalsVM: viewModel.medalsViewModel)
                Spacer()
            }
            .padding(.top)
            .navigationTitle("Perfil")
        }
    }
    
}
