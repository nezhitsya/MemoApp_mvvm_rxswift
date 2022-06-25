//
//  Memo.swift
//  MemoApp
//
//  Created by 이다영 on 2022/06/25.
//

import Foundation

struct Memo: Equatable {
    var content: String
    var date: Date
    var category: String
    
    init(content: String, date: Date = Date()) {
        self.content = content
        self.date = date
        self.category = "\(date.timeIntervalSinceReferenceDate)"
    }
    
    init(original: Memo, updatedContent: String) {
        self = original
        self.content = updatedContent
    }
    
}
