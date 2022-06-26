//
//  SceneCoordinatorType.swift
//  MemoApp
//
//  Created by 이다영 on 2022/06/25.
//

import Foundation
import RxSwift

protocol SceneCoordinatorType {
    @discardableResult
    func transition(to scene: Scene, using style: TransitionStyle, animated: Bool) -> Completable
    
    @discardableResult
    func close(animated: Bool) -> Completable
}
