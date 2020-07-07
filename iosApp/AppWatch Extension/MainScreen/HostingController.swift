//
//  HostingController.swift
//  WatchApp Extension
//
//  Created by Максим Сытый on 22.06.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import WatchKit
import Foundation
import SwiftUI

class HostingController: WKHostingController<MainScreenWatch> {
    override var body: MainScreenWatch {
        return MainScreenWatch()
    }
}
