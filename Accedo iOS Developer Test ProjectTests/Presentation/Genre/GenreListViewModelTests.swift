//
//  GenreListViewModelTests.swift
//  Accedo iOS Developer Test ProjectTests
//
//  Created by Abu Umair Jihan on 2022-04-03.
//

import XCTest
import Combine
@testable import Accedo_iOS_Developer_Test_Project

class GenreListViewModelTests: XCTestCase {

    
    let genreList: GenreList = {
        let genre1 = Genre(id: 1, name: "genre1")
        let genre2 = Genre(id: 2, name: "genre2")
        return GenreList(genres: [genre1, genre2])
    }()
    
    private var observers: [AnyCancellable] = []
    
    struct GenreRepositoryMock: GenreRepository {
        var response: (result: Response?, error: ErrorResponse?)
        func getGenreList(completion: @escaping (_ result: Response?, _ error: ErrorResponse?) -> Void) {
            completion(response.result, response.error)
        }
    }
    
    func testFetchGenresUseCase_RetrievesGenres(){
        
        let expectation = self.expectation(description: "Fetch genres")
        
        let genreRepository = GenreRepositoryMock(response: (result: self.genreList, error: nil))
        let useCase = FetchGenresUseCase(repository: genreRepository)
        let viewModel = GenreListViewModel(usecase: useCase)
        
        viewModel.fetchGenres()
        viewModel.$items.sink { _ in
            expectation.fulfill()
        }.store(in: &observers)
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(viewModel.items.map { $0.id }, genreList.genres.map { $0.id })
        
    }
    
    func testFetchGenresUseCase_ReturnsError(){
        
        let expectation = self.expectation(description: "Fetch genres")
        
        let genreRepository = GenreRepositoryMock(response: (result: nil, error: ErrorResponse(message: "Server error")))
        let useCase = FetchGenresUseCase(repository: genreRepository)
        let viewModel = GenreListViewModel(usecase: useCase)
        
        viewModel.fetchGenres()
        viewModel.$items.sink { _ in
            expectation.fulfill()
        }.store(in: &observers)
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(viewModel.items.isEmpty)
        
    }

}
