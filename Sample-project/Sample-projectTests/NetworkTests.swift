//
//  Sample_projectTests.swift
//  Sample-projectTests
//
//  Created by 박은비 on 2023/04/15.
//

import XCTest
@testable import Sample_project

import RxSwift
import RxCocoa

final class NetworkTests: XCTestCase {
    var disposeBag: DisposeBag = DisposeBag()
    
    var manager: NetworkManger!
    
    override func setUpWithError() throws {
        manager = NetworkManger(session: URLSession.shared)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        print("tearDownWithError")
        disposeBag = DisposeBag()
    }

    func testRequestSucess() {
        let expectation = XCTestExpectation()
        
        self.manager.reqeust(TestRequest.alwaysSuccess, of: TestResponse.self)
            .subscribe({ e in
                
                switch e {
                case .success(let response):
                    XCTAssertEqual(response, TestResponse.succeedResult)
                    
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
                
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        
        wait(for: [expectation], timeout: 2)
    }

    func testRequestFail() {
        let expectation = XCTestExpectation()
        
        self.manager.reqeust(TestRequest.alwaysFail, of: TestResponse.self)
            .subscribe({ e in
                
                switch e {
                case .success:
                    XCTFail()
                    
                case .failure(let error):
                    XCTAssertTrue(true, error.localizedDescription)
                }
                
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        
        wait(for: [expectation], timeout: 2)
    }

}


// MARK: -
enum TestRequest: ReqeustType {
    
    case alwaysSuccess
    case alwaysFail
    
    var baseURL: String {
        "https://jsonplaceholder.typicode.com"
    }
    
    var path: String {
        switch self {
        case .alwaysSuccess:
            return "/todos/1"
        default:
            return ""
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var queryItems: [URLQueryItem]? {
        nil
    }
    
}

struct TestResponse: Decodable, ResponseType {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}

extension TestResponse: Equatable {
    static var succeedResult: TestResponse {
        TestResponse(userId: 1,
                     id: 1,
                     title: "delectus aut autem",
                     completed: false)
    }
}
