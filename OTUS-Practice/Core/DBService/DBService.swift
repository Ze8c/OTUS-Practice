//
//  DBService.swift
//  OTUS-Practice
//
//  Created by Mak on 21.04.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import Foundation
import RealmSwift

protocol DBAbstract: class {
    func save<T: Object>(elements: Array<T>)
    func getElements<T: Object>() -> Array<T>
}

final class DBImpl: DBAbstract {
    private let realm = try? Realm()
    private let dbQueue = DispatchQueue.main
    
    func save<T: Object>(elements: Array<T>) {
        dbQueue.async {
            do {
                guard let result = self.realm?.objects(T.self) else { return }
                self.realm?.beginWrite()
                self.realm?.delete(result)
                self.realm?.add(elements)
                try self.realm?.commitWrite()
                print(self.realm?.configuration.fileURL?.absoluteURL as Any)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getElements<T: Object>() -> Array<T> {
        var result: Array<T> = []
        if let tmp = realm?.objects(T.self) {
            result.append(contentsOf: tmp)
        }
        return result
    }
}
