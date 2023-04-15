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

final class Sample_projectTests: XCTestCase {
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
        self.manager.reqeust(TestEndpoint.test, of: TestResponse.self)
            .subscribe({ e in
                print(e)
            })
//            .subscribe(onSuccess: { res in
//                print(res)
//            }, onFailure: { er in
//                print(er)
//            })
            .disposed(by: disposeBag)
        
        
        wait(for: [expectation], timeout: 2)
    }

    func testRequestFail() {
        
    }

}


// MARK: -
enum TestEndpoint: ReqeustType {
    
    case test
    
    var baseURL: String {
        "https://jsonplaceholder.typicode.com"
    }
    
    var path: String {
        switch self {
        case .test:
            return "/todos/1"
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
