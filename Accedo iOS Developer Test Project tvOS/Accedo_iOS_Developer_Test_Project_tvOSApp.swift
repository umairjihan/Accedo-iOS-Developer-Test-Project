//
//  Accedo_iOS_Developer_Test_Project_tvOSApp.swift
//  Accedo iOS Developer Test Project tvOS
//
//  Created by Abu Umair Jihan on 2022-04-03.
//

import SwiftUI

@main
struct Accedo_iOS_Developer_Test_Project_tvOSApp: App {
    var body: some Scene {
        WindowGroup {
            let repository = GenreRepositoryIMPL(remote: GenreRemoteService())
            let useCase = FetchGenresUseCase(repository: repository)
            let viewModel = GenreListViewModel(usecase: useCase)
            GenreListView(viewModel: viewModel)
        }
    }
}
