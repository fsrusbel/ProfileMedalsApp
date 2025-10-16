//
//  ModulesView.swift
//  ProfileMedalsApp
//
//  Created by usuariolocal on 16/10/25.
//

import SwiftUI

struct ModulesView: View {
    
    @ObservedObject var medalsVM: MedalsViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 28) {

            VStack(alignment: .leading, spacing: 12) {
                Text("🏅 Medallas")
                    .font(.headline)
                MedalsView(viewModel: medalsVM)
            }
            
            VStack(alignment: .leading, spacing: 12) {
                Text("🎯 Misiones")
                    .font(.headline)
                Text("Próximamente...")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            // 🔥 Rachas (placeholder)
            VStack(alignment: .leading, spacing: 12) {
                Text("🔥 Rachas")
                    .font(.headline)
                Text("Sin actividad reciente")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            // 📸 Álbum (placeholder)
            VStack(alignment: .leading, spacing: 12) {
                Text("📸 Álbum")
                    .font(.headline)
                Text("Aún no tienes fotos")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.horizontal)
    }
    
}

