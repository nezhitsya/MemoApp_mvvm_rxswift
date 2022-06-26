//
//  MemoListViewController.swift
//  MemoApp
//
//  Created by 이다영 on 2022/06/25.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class MemoListViewController: UIViewController, ViewModelBindableType {

    var viewModel: MemoListViewModel!
    @IBOutlet weak var listTable: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func bindViewModel() {
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)
        
        viewModel.memoList
            .bind(to: listTable.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: rx.disposeBag)
        
        addButton.rx.action = viewModel.createAction()
        
        Observable.zip(listTable.rx.modelSelected(Memo.self), listTable.rx.itemSelected)
            .do(onNext: { [unowned self] (_, indexPath) in
                self.listTable.deselectRow(at: indexPath, animated: true)
            })
            .map {$0.0}
            .bind(to: viewModel.detailAction.inputs)
            .disposed(by: rx.disposeBag)
        
        listTable.rx.modelDeleted(Memo.self)
            .bind(to: viewModel.deleteAction.inputs)
            .disposed(by: rx.disposeBag)
    }

}
