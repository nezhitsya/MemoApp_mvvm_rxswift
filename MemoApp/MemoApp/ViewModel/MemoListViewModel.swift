//
//  MemoListViewModel.swift
//  MemoApp
//
//  Created by 이다영 on 2022/06/25.
//

import Foundation
import RxSwift
import RxCocoa

class MemoListViewModel: CommonViewModel {
    var memoList: Observable<[Memo]> {
        return storage.memoList()
    }
}
