//
//  SampleStep.swift
//  RxMemo
//
//  Created by 박은비 on 2023/04/09.
//

import RxFlow

enum SampleStep: Step {
    
    // MemoReading
    case memoList
    case memoDetail
    
    // MemoWriting
    case memoComposeIsRequired
    case memoComposeIsComplete
    
}
