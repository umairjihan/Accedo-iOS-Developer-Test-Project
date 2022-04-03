//
//  Accedo_iOS_Developer_Test_ProjectApp.swift
//  Accedo iOS Developer Test Project
//
//  Created by Abu Umair Jihan on 2022-04-01.
//

import SwiftUI

@main
struct Accedo_iOS_Developer_Test_ProjectApp: App {
    var body: some Scene {
        WindowGroup {
            let repository = GenreRepositoryIMPL(remote: GenreRemoteService())
            let useCase = FetchGenresUseCase(repository: repository)
            let viewModel = GenreListViewModel(usecase: useCase)
            GenreListView(viewModel: viewModel)
        }
    }
}
