//
//  LocalizeTextVM.swift
//  OTUS-Practice
//
//  Created by Mak on 15.05.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import Combine
import Foundation

enum Locales: String {
    case ru
    case uk
    case fr
    case china
    
    var getLocale: Locale {
        let res: Locale
        switch self {
        case .ru:
            res = Locale(identifier: "ru_RU")
        case .uk:
            res = Locale(identifier: "en")
        case .fr:
            res = Locale(identifier: "fr")
        case .china:
            res = Locale(identifier: "zh_CN")
        }
        return res
    }
    
    func get(fromDate date: Date, withFormat format: String) -> String {
        
        let df: DateFormatter = {
            $0.locale = self.getLocale
            $0.setLocalizedDateFormatFromTemplate(format)
            return $0
        }(DateFormatter())
        
        return df.string(from: date)
    }
    
    func get<A: Unit>(measurement: Measurement<A>) -> String {
        let mf: MeasurementFormatter = {
            $0.locale = self.getLocale
            return $0
        }(MeasurementFormatter())
        return mf.string(from: measurement)
    }
}

final class LocalizeTextVM: ObservableObject {
    
    @Published var sharedText: String = ""
    @Published var secondText: String = ""
    @Published var selectedLocale: Locales = .ru
    var locales: Array<Locales> = [.ru, .uk, .fr, .china]
    
    private var bag = Set<AnyCancellable>()
    private let cacheService: SharingServiceAbstract
    
    init(withService service: SharingServiceAbstract) {
        cacheService = service
        
        $selectedLocale
            .sink(receiveValue: change(_:))
            .store(in: &bag)
    }
    
    func getTxt() {
        let txt = cacheService.getShare()
        if sharedText != txt {
            sharedText = txt
        }
    }
    
    private func change(_ locale: Locales) {
        var tmpTxt: String = "Locale: " + locale.rawValue + "\n"
        
        let temp = "dMMMMyEEEE"
        tmpTxt += "Date: " + locale.get(fromDate: Date(), withFormat: temp) + "\n"
        
        let dist = Measurement(value: 15, unit: UnitLength.kilometers)
        tmpTxt += "Measurement: " + locale.get(measurement: dist)
        
        secondText = tmpTxt
    }
}
