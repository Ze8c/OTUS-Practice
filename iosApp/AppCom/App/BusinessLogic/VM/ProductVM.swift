//
//  ProductVM.swift
//  OTUS-Practice
//
//  Created by Mak on 04.03.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

//import Foundation
//import Combine
//
//final class ProductVM: ObservableObject {
//
//    private var bag = Set<AnyCancellable>()
//    private let cache = Cache<ProductDB, [ProductDB]>()
//
//    @Published var selected: Int? = nil
//    @Published var query: String = ""
//    @Published var lastAppearElement: ProductDB = .naught
//
//    @Published private(set) var list: Array<ProductDB> = []
//    @Published private(set) var isLoaded: Bool = true
//
//    @Published var filter: String = ProductDBType.anime.rawValue
//    var filters: Array<String>
//
//    init(serviceAPI: AbstractAnimeAPI?, db: DBAbstract?) {
//
//        filters = ProductDBType.allCases
//            .map { $0.rawValue }
//
//        guard let service = serviceAPI, let dataBase = db else { return }
//
//        $filter
//            .sink { service.tmpFilter = $0 }
//            .store(in: &bag)
//
//        $query
//            .filter { $0.count > 2 }
//            .compactMap(service.get)
//            .sink(receiveValue: resFlag(dataBase))
//            .store(in: &bag)
//
//        $lastAppearElement
//            .filter { _ in service.listInit }
//            .map(service.nextPage)
//            .sink(receiveValue: result(dataBase))
//            .store(in: &bag)
//
//        self.list = dataBase.getElements()
//    }
//
//    private func resFlag(_ db: DBAbstract)
//        -> (Published<Array<ProductDB>>.Publisher, Published<Bool>.Publisher)
//        -> Void {
//            return { [weak self] (v, f) in
//                guard let self = self else { return }
//                DispatchQueue.main.async {
//                    f.assign(to: \.isLoaded, on: self).store(in: &self.bag)
//                    self.result(db)(v)
//                }
//            }
//    }
//
//    private func result(_ db: DBAbstract) -> (Published<Array<ProductDB>>.Publisher) -> Void {
//        return { [weak self] (v) in
//            guard let self = self else { return }
//            DispatchQueue.main.async {
//                v.sink(receiveValue: db.save(elements:)).store(in: &self.bag)
//                v.assign(to: \.list, on: self).store(in: &self.bag)
//            }
//        }
//    }
//}
