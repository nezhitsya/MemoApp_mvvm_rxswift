//
//  TransitionModel.swift
//  MemoApp
//
//  Created by 이다영 on 2022/06/25.
//

import Foundation

enum TransitionStyle {
    case root
    case push
    case modal
}

enum TransitionError: Error {
    case navigationControllerMissing
    case cannotPop
    case unknown
}
