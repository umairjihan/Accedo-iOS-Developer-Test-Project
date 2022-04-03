//
//  MovieListViewModelTests.swift
//  Accedo iOS Developer Test ProjectTests
//
//  Created by Abu Umair Jihan on 2022-04-03.
//

import XCTest
import Combine
@testable import Accedo_iOS_Developer_Test_Project

class MovieListViewModelTests: XCTestCase {

    
    private var observers: [AnyCancellable] = []
    
    let movieList: [MovieList] = {
        let movie1 = Movie(adult: nil, backdropPath: nil, genreIDS: nil, id: 1, originalLanguage: nil, originalTitle: nil, overview: nil, popularity: nil, posterPath: "posterPath1", releaseDate: "releaseDate1", title: "title1", video: nil, voteAverage: nil, voteCount: nil)
        let movie2 = Movie(adult: nil, backdropPath: nil, genreIDS: nil, id: 2, originalLanguage: nil, originalTitle: nil, overview: nil, popularity: nil, posterPath: "posterPath2", releaseDate: "releaseDate2", title: "title2", video: nil, voteAverage: nil, voteCount: nil)
        let page1 = MovieList(page: 1, results: [movie1, movie2], totalPages: 2, totalResults: 3)
        
        let movie3 = Movie(adult: nil, backdropPath: nil, genreIDS: nil, id: 3, originalLanguage: nil, originalTitle: nil, overview: nil, popularity: nil, posterPath: "posterPath3", releaseDate: "releaseDate3", title: "title3", video: nil, voteAverage: nil, voteCount: nil)
        let page2 = MovieList(page: 2, results: [movie3], totalPages: 2, totalResults: 3)
        
        return [page1, page2]
    }()
    
    class MovieRepositoryMock: MovieRepository {
        
        var response: (result: Response?, error: ErrorResponse?)
        
        init( response: (result: Response?, error: ErrorResponse?) ){
            self.response = response
        }
        
        func getMovieList(page: Int, genre: Int, completion: @escaping (_ result: Response?, _ error: ErrorResponse?) -> Void) {
            completion(response.result, response.error)
        }
    }
    
    func testFetchMoviesUseCase_RetrievesFirstPage(){
        
        let expectation = self.expectation(description: "Only first page")
        
        let movieRepository = MovieRepositoryMock(response: (result: self.movieList.first, error: nil))
        let useCase = FetchMoviesUseCase(repository: movieRepository, page: 1, genre: 11)
        let viewModel = MovieListViewModel(usecase: useCase)
        
        viewModel.fetchMovies()
        viewModel.$items.sink { _ in
            expectation.fulfill()
        }.store(in: &observers)
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(viewModel.page, 1)
        XCTAssertEqual(viewModel.items.map { $0.id }, self.movieList.first?.results.map { $0.id })
        XCTAssertTrue(viewModel.shouldFetchNextPage(item: viewModel.items.last!))
    }
    
    func testFetchMoviesUseCase_RetrievesFirstAndSecondPage(){
        
        var expectation = self.expectation(description: "First page loaded")
        let movieRepository = MovieRepositoryMock(response: (result: self.movieList.first, error: nil))
        let useCase = FetchMoviesUseCase(repository: movieRepository, page: 1, genre: 11)
        let viewModel = MovieListViewModel(usecase: useCase)
        
        viewModel.fetchMovies()
        viewModel.$items.sink { _ in
            expectation.fulfill()
        }.store(in: &observers)
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(viewModel.page, 1)
        XCTAssertEqual(viewModel.items.map { $0.id }, self.movieList.first?.results.map { $0.id })
        XCTAssertTrue(viewModel.shouldFetchNextPage(item: viewModel.items.last!))
        
        expectation = self.expectation(description: "Second page loaded")
        
        movieRepository.response = (result: self.movieList.last, error: nil)

        viewModel.didLoadNextPage()

        waitForExpectations(timeout: 5, handler: nil)

        XCTAssertEqual(viewModel.page, 2)
        XCTAssertEqual(viewModel.items.map { $0.id }, self.movieList.flatMap { $0.results }.map { $0.id } )
        XCTAssertFalse(viewModel.shouldFetchNextPage(item: viewModel.items.last!))
        
    }
    
    func testFetchMoviesUseCase_ReturnsError(){
        
        let expectation = self.expectation(description: "errors")

        let movieRepository = MovieRepositoryMock(response: (result: nil, error: ErrorResponse(message: "Server error")))
        let useCase = FetchMoviesUseCase(repository: movieRepository, page: 1, genre: 11)
        let viewModel = MovieListViewModel(usecase: useCase)
        
        viewModel.fetchMovies()
        viewModel.$items.sink { _ in
            expectation.fulfill()
        }.store(in: &observers)
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(viewModel.items.isEmpty)
        
    }


}
