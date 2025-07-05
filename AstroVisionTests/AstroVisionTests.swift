//
//  AstroVisionTests.swift
//  AstroVisionTests
//
//  Created by Rajini's Macbook Pro  on 01/07/2025.
//

import XCTest
@testable import AstroVision

final class AstroVisionTests: XCTestCase {
    
    var viewModel: APODViewModel!
    var mockAPODService: MockCAPODService!
    var mockUrlConfigs : URLConfigurations!
    @MainActor override func setUp() {
        super.setUp()
        mockUrlConfigs = MockURLConfigurations.shared
        mockUrlConfigs.fetchConfigs()
        mockAPODService = MockCAPODService(urlConfigs: MockURLConfigurations.shared)
        viewModel = APODViewModel()
        viewModel.apodURLService = mockAPODService
    }
    
    override func tearDown() {
        viewModel = nil
        mockAPODService = nil
        mockUrlConfigs = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func testFetchDataFailure() async {
        mockAPODService.shouldReturnError = true
        try? await viewModel.fetchAPOD()
        await Task { @MainActor in
            XCTAssertTrue(viewModel.errorMessage != nil)
        }.value
    }
    
    func testFetchDataFailureWithErrorConfigs() async {
        await Task { @MainActor in
        let configs = MockURLConfigurations.shared
        configs.urlConfigs = nil
        mockAPODService = MockCAPODService(urlConfigs: configs)
        viewModel.apodURLService = mockAPODService
        try? await viewModel.fetchAPOD(for: "dummy string")
            XCTAssertTrue(viewModel.errorMessage != nil)
        }.value
    }
    
    func testFetchDataSucess() async {
        mockAPODService.shouldReturnError = false
        try? await viewModel.fetchAPOD()
        await Task { @MainActor in
            XCTAssertTrue(viewModel.apod != nil)
        }.value
    }

    func testFetchDataSucessWithDate() async {
        mockAPODService.shouldReturnError = false
        try? await viewModel.fetchAPOD(for: "2025-07-01")
        await Task { @MainActor in
            XCTAssertTrue(viewModel.apod != nil)
        }.value
    }
    
    func testFetchDataSuccessWithVideo() async {
        mockAPODService.shouldReturnError = false
        mockAPODService.isVideoURLIncluded = true
        try? await viewModel.fetchAPOD(for: "2025-07-01")
        await Task { @MainActor in
            XCTAssertTrue(viewModel.apod != nil)
        }.value
    }
   
    
    func testURLConfigs() {
        let configs = MockURLConfigurations.shared
        let url = configs.getUrl(with: "2025-07-01")
        XCTAssertNotNil(url)
    }
    
  

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}



class MockCAPODService: APODUrlService {
    var shouldReturnError: Bool = false
    var isVideoURLIncluded: Bool = false

    override func fetchApod(with date: String?) async throws -> APOD? {
        if shouldReturnError {
            throw APIClientError.authError
        }
        if self.urlConfigs.getUrl(with: date) == nil {
            throw APIClientError.authError
        }
        
        if isVideoURLIncluded {
            return APOD(title: "title", explanation: "explanation", url: "https://www.youtube.com/embed/CC7OJ7gFLvE?rel=0", mediaType: .video, date: "date")
        }
        return APOD(title: "title", explanation: "explanation", url: "https://apod.nasa.gov/apod/image/2507/Ou4_difusco1024.jpg", mediaType: .image, date: "date")
    }
}

class MockURLConfigurations: URLConfigurations {
    override func getUrl(with date: String?) -> URL? {
        super.getUrl(with: date)
    }
}
