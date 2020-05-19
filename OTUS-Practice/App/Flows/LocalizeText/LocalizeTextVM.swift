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
    
    var getImpl: Locale {
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
            $0.locale = self.getImpl
            $0.setLocalizedDateFormatFromTemplate(format)
            return $0
        }(DateFormatter())
        
        return df.string(from: date)
    }
    
    func get<A: Unit>(measurement: Measurement<A>) -> String {
        let mf: MeasurementFormatter = {
            $0.locale = self.getImpl
            return $0
        }(MeasurementFormatter())
        return mf.string(from: measurement)
    }
    
    func convert(_ txt: String, convertTypes types: [TypeConvert]) -> String {
        var resultTxt: String = ""
        var nsText = txt as NSString
        
        types.forEach { type in
            var offset = 0
            if let regex = try? NSRegularExpression(pattern: type.regex) {
                let result = regex.matches(in: txt, range: NSRange(txt.startIndex..., in: txt))
                result.forEach {
                    var range = NSRange()
                    range.location = $0.range.location + offset
                    range.length = $0.range.length
                    let replacement = String(nsText.substring(with: range))
                    let convertedString = type.processor(self.getImpl, replacement)
                    nsText = nsText.replacingCharacters(in: range, with: convertedString) as NSString
                    offset += convertedString.count - $0.range.length
                }
            }
            resultTxt = nsText as String
        }
        
        return resultTxt
    }
}

enum TypeConvert {
    case date(format: String)
    case metrics
    
    var regex: String {
        let r: String
        switch self {
        case .date(_):
            r = #"(\d{1,2}[\Q-.\/\E]\d{1,2}[\Q-.\/\E]\d{2,4})"#
        case .metrics:
            r = #"(\d{1,}\smi\.?|\d{1,}\s{0,}m\.?|\d{1,}\s{0,}km\.?|\d{1,}\s{0,}км\.?|\d{1,}\s{0,}公里\.?)"#
        }
        return r
    }
    
    func processor(_ locale: Locale, _ replacement: String) -> String {
        let r: String
        switch self {
        case let .date(format):
            r = changeDate(replacement, locale: locale, toFormat: format)
        case .metrics:
            r = changeMetrics(replacement, locale: locale)
        }
        return r
    }
    
    private func changeDate(_ txt: String, locale: Locale, toFormat: String) -> String {
        if let date = txt.getDate(withFormat: "dd-MM-yyyy") {
            let formater = DateFormatter()
            formater.locale = locale
            formater.setLocalizedDateFormatFromTemplate(toFormat)
            return formater.string(from: date)
        } else {
            return ""
        }
    }
    
    private func changeMetrics(_ txt: String, locale: Locale) -> String {
        if let measurement = getMeasurement(fromText: txt) {
            let formater = MeasurementFormatter()
            formater.locale = locale
            return formater.string(from: measurement)
        } else {
            return ""
        }
    }
    
    private func measurementUnit(fromText txt: String) -> Unit? {
        if (txt.contains("公里") || txt.contains("км") || txt.contains("km")) {
            return UnitLength.kilometers
        } else if (txt.contains("mi")) {
            return UnitLength.miles
        } else if (txt.contains("м") || txt.contains("m")) {
            return UnitLength.meters
        } else {
            return nil
        }
    }
    
    private func getMeasurement(fromText txt: String) -> Measurement<Unit>? {
        var digit: Double = 0.0
        do{
            let regex = try NSRegularExpression(pattern: #"\d{1,}"#)
            let result = regex.matches(in: txt, range: NSRange(txt.startIndex..., in: txt))
            let nsMeasurement = txt as NSString
            result.forEach { item in
                digit = Double(nsMeasurement.substring(with: item.range)) ?? 0.0
            }
        } catch let error{
            print(error)
            return nil
        }
        if let unit = measurementUnit(fromText: txt) {
            return Measurement(value: digit, unit: unit)
        } else {
            return nil
        }
    }
}

final class LocalizeTextVM: ObservableObject {
    
    @Published var sharedText: String = ""
    @Published var secondText: String = ""
    @Published var selectedLocale: Locales = .ru
    var locales: Array<Locales> = [.ru, .uk, .fr, .china]
    
    private var mainText: String = ""
    private let mockText = "hgsd ashj 300 mi. dgaj ajhsbdja12.30.2010 jda sjhdajhs 2-09-2015 hsgdjh asv 10m. jsd 100km. ajs 11/16/2017jhasdhja3\\3\\2000 s"
    
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
        if mainText != txt {
            mainText = txt
            change(selectedLocale)
        }
    }
    
    private func change(_ locale: Locales) {
        var tmpTxt: String = "Locale: " + locale.rawValue + "\n"
        
        let temp = "dMMMMyEEEE"
        let temp2 = "yyyy.MM.dd G"
        tmpTxt += "Date: " + locale.get(fromDate: Date(), withFormat: temp) + "\n"
        
        let dist = Measurement(value: 15, unit: UnitLength.kilometers)
        tmpTxt += "Measurement: " + locale.get(measurement: dist)
        
        secondText = tmpTxt
        
        sharedText = locale.convert(mainText,
                                    convertTypes: [.date(format: temp), .metrics])
    }
}
