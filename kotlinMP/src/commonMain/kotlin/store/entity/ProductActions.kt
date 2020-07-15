package store.entity

import services.jikanAPI.SearchApi

enum class ProductActions {
    SEARCH {
        override suspend fun doing(api: SearchApi, q: ProductRequest, async: (ProductRequest) -> Unit) {

            q.firstPage = 1

            q.filter.result(api, q.query, q.firstPage) {
                q.firstPage = it.lastPage
                q.result = it.results
                async(q)
            }
        }
    },

    NEXT {
        override suspend fun doing(api: SearchApi, q: ProductRequest, async: (ProductRequest) -> Unit) {
            q.filter.result(api, q.query, q.firstPage) {
                q.firstPage = it.lastPage
                q.result += it.results
                async(q)
            }
        }
    };

    abstract suspend fun doing(api: SearchApi, q: ProductRequest, async: (ProductRequest) -> Unit)
}