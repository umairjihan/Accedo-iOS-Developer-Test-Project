//
//  FetchGenresUseCaseTests.swift
//  Accedo iOS Developer Test ProjectTests
//
//  Created by Abu Umair Jihan on 2022-04-03.
//

import XCTest
import Combine
@testable import Accedo_iOS_Developer_Test_Project

class FetchGenresUseCaseTests: XCTestCase {
    
    
    private var observers: [AnyCancellable] = []
    
    let genreList: GenreList = {
        let genre1 = Genre(id: 1, name: "genre1")
        let genre2 = Genre(id: 2, name: "genre2")
        return GenreList(genres: [genre1, genre2])
    }()
    
    struct GenreRepositoryMock: GenreRepository {
        var response: (result: Response?, error: ErrorResponse?)
        func getGenreList(completion: @escaping (_ result: Response?, _ error: ErrorResponse?) -> Void) {
            completion(response.result, response.error)
        }
    }
    
    func testFetchGenresUseCase_RetrievesGenres(){
        
        let expectation = self.expectation(description: "Fetch genres")
        expectation.expectedFulfillmentCount = 2
        let genreRepository = GenreRepositoryMock(response: (result: self.genreList, error: nil))
        let useCase = FetchGenresUseCase(repository: genreRepository)
        
        var genreList: GenreList? = nil
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
            genreList = response as? GenreList
            expectation.fulfill()
        }).store(in: &observers)
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(genreList != nil)
        XCTAssertEqual(genreList?.genres.map { $0.id }, self.genreList.genres.map { $0.id })
        XCTAssertTrue(errorResponse == nil)
        
        
    }
    
    func testFetchGenresUseCase_ReturnsError(){
        
        let expectation = self.expectation(description: "Fetch genres")
        expectation.expectedFulfillmentCount = 1
        let genreRepository = GenreRepositoryMock(response: (result: nil, error: ErrorResponse(message: "Server error")))
        let useCase = FetchGenresUseCase(repository: genreRepository)
        
        var genreList: GenreList? = nil
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
            genreList = response as? GenreList
            expectation.fulfill()
        }).store(in: &observers)
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(genreList == nil)
        XCTAssertTrue(errorResponse != nil)
        
        
    }
    

}
