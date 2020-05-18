//
//  SharingService.swift
//  OTUS-Practice
//
//  Created by Mak on 15.05.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import Foundation

protocol SharingServiceAbstract: class {
    var dataProvider: DataProvider? { get }
}

extension SharingServiceAbstract {
    func setShare(_ text: String) {
        dataProvider?.set(to: "text", value: text)
    }
    
    func getShare() -> String {
        return dataProvider?.get(from: "text") ?? ""
    }
}

final class SharingService: SharingServiceAbstract {
    
    internal let dataProvider: DataProvider?
    
    init(dataProvider: DataProvider? = FileService()) {
        self.dataProvider = dataProvider
    }
}
