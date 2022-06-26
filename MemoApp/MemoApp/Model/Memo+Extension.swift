//
//  Memo+Extension.swift
//  MemoApp
//
//  Created by 이다영 on 2022/06/26.
//

import Foundation
import RxDataSources
import CoreData
import RxCoreData

extension Memo: Persistable {
    static var entityName: String {
        return "Memo"
    }
    
    static var primaryAttributeName: String {
        return "identity"
    }
    
    init(entity: NSManagedObject) {
        content = entity.value(forKey: "content") as! String
        date = entity.value(forKey: "date") as! Date
        identity = "\(date.timeIntervalSinceReferenceDate)"
    }
    
    func update(_ entity: NSManagedObject) {
        entity.setValue(content, forKey: "content")
        entity.setValue(date, forKey: "date")
        entity.setValue("\(date.timeIntervalSinceReferenceDate)", forKey: "identity")
                
        do {
            try entity.managedObjectContext?.save()
        } catch let e {
            print(e)
        }
    }
    
}
