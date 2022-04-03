//
//  MovieCellView.swift
//  Accedo iOS Developer Test Project
//
//  Created by Abu Umair Jihan on 2022-04-02.
//

import SwiftUI
import Kingfisher

struct MovieCellView <VM: MovieListItemViewModel> : View {
    
    var viewModel: VM
    
    var body: some View {
        HStack {
            KFImage(viewModel.imageUrl)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50, alignment: .leading)
            Text(viewModel.movietitle)
        }
        
    }
}

struct MovieCellView_Previews: PreviewProvider {
    static var previews: some View {
        MovieCellView(viewModel: MovieListItemViewModel(id: 0, movietitle: "", imagePath: ""))
    }
}
