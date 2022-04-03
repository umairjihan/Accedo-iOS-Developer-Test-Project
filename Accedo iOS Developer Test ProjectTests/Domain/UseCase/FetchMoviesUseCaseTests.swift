//
//  FetchMoviesUseCaseTests.swift
//  Accedo iOS Developer Test ProjectTests
//
//  Created by Abu Umair Jihan on 2022-04-03.
//

import XCTest
import Combine
@testable import Accedo_iOS_Developer_Test_Project

class FetchMoviesUseCaseTests: XCTestCase {

    
    private var observers: [AnyCancellable] = []
    
    let movieList: MovieList = {
        let movie = Movie(adult: nil, backdropPath: nil, genreIDS: nil, id: 1, originalLanguage: nil, originalTitle: nil, overview: nil, popularity: nil, posterPath: "posterPath", releaseDate: "releaseDate", title: "title", video: nil, voteAverage: nil, voteCount: nil)
        return MovieList(page: 1, results: [movie], totalPages: 1, totalResults: 1)
    }()
    
    struct MovieRepositoryMock: MovieRepository {
        var response: (result: Response?, error: ErrorResponse?)
        func getMovieList(page: Int, genre: Int, completion: @escaping (_ result: Response?, _ error: ErrorResponse?) -> Void) {
            completion(response.result, response.error)
        }
    }
    
    
    func testFetchMoviesUseCase_RetrievesMovies(){
        
        let expectation = self.expectation(description: "Fetch movies")
        expectation.expectedFulfillmentCount = 2
        let movieRepository = MovieRepositoryMock(response: (result: self.movieList, error: nil))
        let useCase = FetchMoviesUseCase(repository: movieRepository, page: 1, genre: 11)
        
        var movieList: MovieList? = nil
        var errorResponse: ErrorResponse? = nil
        
        useCase.start().sink ( receiveCompletion:{  completion in
            switch completion {
            case .finished:
                print("Finished calling")
            case .failure(let error):
                print("Error calling \(error)")
                errorResponse = error
            }
            expectation.fulfill()
        }, receiveValue: { response in
            movieList = response as? MovieList
            expectation.fulfill()
        }).store(in: &observers)
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(movieList != nil)
        XCTAssertTrue(movieList?.page == self.movieList.page)
        XCTAssertEqual(movieList?.results.map { $0.id }, self.movieList.results.map { $0.id })
        XCTAssertTrue(errorResponse == nil)
        
        
    }
    
    func testFetchGenresUseCase_ReturnsError(){
        
        let expectation = self.expectation(description: "Fetch movies")

        let movieRepository = MovieRepositoryMock(response: (result: nil, error: ErrorResponse(message: "Server error")))
        let useCase = FetchMoviesUseCase(repository: movieRepository, page: 1, genre: 11)
        
        var movieList: MovieList? = nil
        var errorResponse: ErrorResponse? = nil
        
        useCase.start().sink ( receiveCompletion:{  completion in
            switch completion {
            case .finished:
                print("Finished calling")
            case .failure(let error):
                print("Error calling \(error)")
                errorResponse = error
            }
            expectation.fulfill()
        }, receiveValue: { response in
            movieList = response as? MovieList
            expectation.fulfill()
        }).store(in: &observers)
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(movieList == nil)
        XCTAssertTrue(errorResponse != nil)
        
        
    }

}
