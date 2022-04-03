//
//  MovieFlowCoordinator.swift
//  Accedo iOS Developer Test Project
//
//  Created by Abu Umair Jihan on 2022-04-02.
//

import SwiftUI

protocol MovieFlowStateProtocol: ObservableObject {
    var activeLink: MovieLink? { get set }
}

enum MovieLink: Hashable { }

struct MovieFlowCoordinator<State: MovieFlowStateProtocol, Content: View>: View {

    @ObservedObject var state: State
    let content: () -> Content

    var body: some View {
        content()
    }
}
