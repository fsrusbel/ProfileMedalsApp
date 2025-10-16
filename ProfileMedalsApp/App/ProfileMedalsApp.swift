//
//  ProfileMedalsApp.swift
//  ProfileMedalsApp
//
//  Created by usuariolocal on 16/10/25.
//

import SwiftUI
import SwiftData

@main
struct ProfileMedalsApp: App {
    
    @Environment(\.scenePhase) private var scenePhase
    @StateObject private var di: AppDIContainer

    init() {
        let container: ModelContainer
        do {
            container = try ModelContainer(
                for: MedalEntity.self,
                configurations: ModelConfiguration(isStoredInMemoryOnly: false)
            )
        } catch {
            fatalError("Unable to create ModelContainer: \(error)")
        }

        _di = StateObject(wrappedValue: AppDIContainer(container: container))
    }

    var body: some Scene {
        WindowGroup {
            RootView(di: di)
                .modelContainer(di.container)
                .onChange(of: scenePhase) { newPhase in
                    Task {
                        switch newPhase {
                        case .active:
                            await di.pointsEngine.resume()
                        case .background:
                            await di.pointsEngine.pause()
                        default:
                            break
                        }
                    }
                }
        }
    }
    
}

