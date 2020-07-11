//
//  FileService.swift
//  OTUS-Practice
//
//  Created by Mak on 15.05.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import Foundation

final class FileService: DataProvider {
    
    private let provider: FileManager?
    private let docPath: String
    
    init(with fm: FileManager? = FileManager.default) {// = UserDefaults(suiteName: "group.com.otus-pracitce.my")) {
        provider = fm
        
        if let uri = FileManager().containerURL(forSecurityApplicationGroupIdentifier: "group.com.otus-pracitce.my") {
            docPath = "\(uri.path)/share"
        } else {
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let uri = paths[0] as String
            docPath = "\(uri)/share"
        }
    }
    
    func set(to key: String, value: String) {
        let docURI = docPath + "/" + key + ".cache"
        
        guard let prov = provider
        else {
            print("LOG > Don't have provider")
            return
        }
        
        if value.isEmpty {
            print("LOG > Empty value")
        } else {
            if !prov.fileExists(atPath: docURI) {
                do {
                    try prov.createDirectory(atPath: docPath, withIntermediateDirectories: true, attributes: nil)
                } catch {
                    print("LOG > Don't create directory")
                }
                
                guard prov.createFile(atPath: docURI, contents: nil, attributes: nil)
                else {
                    print("LOG > Don't create file")
                    return
                }
            }
            
            do {
                let dataP = try JSONEncoder().encode(value)
                try dataP.write(to: URL(fileURLWithPath: docURI), options: .atomic)
            } catch (let err) {
                print(err)
            }
        }
    }
    
    func get(from key: String) -> String {
        let docURI = docPath + "/" + key + ".cache"
        var result: String = ""
        
        guard let prov = provider
        else {
            print("LOG > Don't have provider")
            return result
        }
        
        if let file = prov.contents(atPath: docURI) {
            do {
                result = try JSONDecoder().decode(String.self, from: file)
            } catch (let err) {
                print(err)
            }
        }
        
        return result
    }
}
