//
//  SampleStep.swift
//  Sample-project
//
//  Created by 박은비 on 2023/04/09.
//

import RxFlow

enum SampleStep: Step {
    
    case dashboardIsRequired
    
    // MARK: - Memo
    
    // MemoReading
    case memoList
    case memoDetail(_ memo: Memo)
    case memoDetailIsComplete
    
    // MemoWriting
    case memoComposeIsRequired
    case memoComposeIsComplete
    
    
    // MARK: - GithubSearch
    case githubSearchMain
    case githubSearchList(_ searchKeyword: String)
    
}
