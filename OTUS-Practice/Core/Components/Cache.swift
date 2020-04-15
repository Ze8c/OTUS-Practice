//
//  Cache.swift
//  OTUS-Practice
//
//  Created by Mak on 15.04.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import Foundation

final class Cache<Key: Codable, Value: Any>: ObservableObject {
    
    @Published var result: Value?
    
    private let provider: FileManager
    private let document: String
    
    init() {
        provider = FileManager.default
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docPath = paths[0] as NSString
        document = docPath.appending("/" + String(describing: Key.self) + ".cache")
    }
    
    func add(value: Value) {
        if let val = value as? [Key], !val.isEmpty {
            do {
                let dataP = try JSONEncoder().encode(val)
                if !provider.fileExists(atPath: document) {
                    if provider.createFile(atPath: document, contents: nil, attributes: nil) {
                        print("[LOG] Create file")
                    } else {
                        print("[LOG] Don't create file")
                        return
                    }
                }
                try dataP.write(to: URL(fileURLWithPath: document), options: .atomic)
                print("[LOG] Write file")
            } catch (let err) {
                print(err)
            }
        } else {
            print("[LOG] Empty value")
        }
    }
    
    func getValue() -> Published<Value?>.Publisher {
        if let file = provider.contents(atPath: document) {
            do {
                let info = try JSONDecoder().decode([Key].self, from: file)
                result = (info as! Value)
            } catch (let err) {
                print(err)
            }
        }
        return $result
    }
}
