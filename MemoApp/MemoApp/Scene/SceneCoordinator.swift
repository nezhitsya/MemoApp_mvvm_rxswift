//
//  SceneCoordinator.swift
//  MemoApp
//
//  Created by 이다영 on 2022/06/25.
//

import Foundation
import RxSwift
import RxCocoa

extension UIViewController {
    var sceneViewController: UIViewController {
        return self.children.first ?? self
    }
}

class SceneCoordinator: SceneCoordinatorType {
    private let bag = DisposeBag()
    private var window: UIWindow
    private var currentViewController: UIViewController
    
    required init(window: UIWindow) {
        self.window = window
        currentViewController = window.rootViewController!
    }
    
    @discardableResult
    func transition(to scene: Scene, using style: TransitionStyle, animated: Bool) -> Completable {
        let subject = PublishSubject<Void>()
        let target = scene.instantiate()
        
        switch style {
        case .root:
            currentViewController = target.sceneViewController
            window.rootViewController = target
            subject.onCompleted()
        case .push:
            guard let nav = currentViewController.navigationController else {
                subject.onError(TransitionError.navigationControllerMissing)
                break
            }
            
            nav.rx.willShow
                .subscribe(onNext: { [unowned self] event in
                    self.currentViewController = event.viewController.sceneViewController
                })
                .disposed(by: bag)
            
            nav.pushViewController(target, animated: animated)
            currentViewController = target.sceneViewController
            
            subject.onCompleted()
        case .modal:
            currentViewController.present(target, animated: animated) {
                subject.onCompleted()
            }
            
            currentViewController = target.sceneViewController
        }
        
        return subject.ignoreElements().asCompletable()
    }
    
    @discardableResult
    func close(animated: Bool) -> Completable {
        return Completable.create { [unowned self] completable in
            if let presentViewController = self.currentViewController.presentingViewController {
                self.currentViewController.dismiss(animated: animated) {
                    self.currentViewController = presentViewController.sceneViewController
                    completable(.completed)
                }
            } else if let nav = self.currentViewController.navigationController {
                guard nav.popViewController(animated: animated) != nil else {
                    completable(.error(TransitionError.cannotPop))
                    return Disposables.create()
                }
                
                self.currentViewController = nav.viewControllers.last!
                completable(.completed)
            } else {
                completable(.error(TransitionError.unknown))
            }
            
            return Disposables.create()
        }
    }
    
}
