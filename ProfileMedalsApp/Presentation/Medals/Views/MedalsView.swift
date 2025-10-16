//
//  MedalsView.swift
//  ProfileMedalsApp
//
//  Created by usuariolocal on 16/10/25.
//

import SwiftUI

struct MedalsView: View {
    
    @ObservedObject var viewModel: MedalsViewModel
    private let columns = [GridItem(.adaptive(minimum: 160), spacing: 12)]

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(viewModel.medals) { m in
                    MedalCardView(
                        viewState: m,
                        animate: viewModel.animateLevelUpMedalID == m.id
                    )
                    .padding(6)
                    .animation(.easeInOut(duration: 0.4), value: m.points)
                }
            }
            .padding(.horizontal)
        }
        .frame(maxHeight: 520)
    }
    
}

