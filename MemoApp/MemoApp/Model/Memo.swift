//
//  Memo.swift
//  MemoApp
//
//  Created by 이다영 on 2022/06/25.
//

import Foundation
import RxDataSources

struct Memo: Equatable, IdentifiableType {
    var content: String
    var date: Date
    var identity: String
    
    init(content: String, date: Date = Date()) {
        self.content = content
        self.date = date
        self.identity = "\(date.timeIntervalSinceReferenceDate)"
    }
    
    init(original: Memo, updatedContent: String) {
        self = original
        self.content = updatedContent
    }
    
}
