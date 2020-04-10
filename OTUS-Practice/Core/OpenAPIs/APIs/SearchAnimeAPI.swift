//
// SearchAnimeAPI.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation



open class SearchAnimeAPI {
    /**
     Get Anime
     
     - parameter q: (query) Query 
     - parameter page: (query) Paging 
     - parameter apiResponseQueue: The queue on which api response is dispatched.
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getAnime(q: String, page: Int, filter: String, apiResponseQueue: DispatchQueue = OpenAPIClientAPI.apiResponseQueue, completion: @escaping ((_ data: ProductList?) -> Void)) {
        getAnimeWithRequestBuilder(q: q, page: page, filter: filter).execute(apiResponseQueue) { result -> Void in
            switch result {
            case let .success(response):
                completion(response.body)
            case let .failure(error):
                completion(nil)
                print("[ERROR]", String(describing: self), ":", #function, "->", error.localizedDescription)
            }
        }
    }

    /**
     Get Anime
     - GET /search/anime
     - parameter q: (query) Query 
     - parameter page: (query) Paging 
     - returns: RequestBuilder<ProductList> 
     */
    open class func getAnimeWithRequestBuilder(q: String, page: Int, filter: String) -> RequestBuilder<ProductList> {
        let path = "/search/\(filter)"
        let URLString = OpenAPIClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
            "q": q.encodeToJSON(), 
            "page": page.encodeToJSON()
        ])

        let requestBuilder: RequestBuilder<ProductList>.Type = OpenAPIClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

}
