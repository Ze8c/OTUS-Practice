package store

import services.jikanAPI.SearchApi
import services.jikanAPI.models.Product
import services.jikanAPI.models.ProductList

typealias StoreSubscriber <S> = (S) -> Unit

enum class ProductType {
    ANIME {
        override fun result(api: SearchApi, q: String, page: Int, async: (ProductList) -> Unit) {
            api.getAnime(q, page, async)
        }
    },

    MANGA {
        override fun result(api: SearchApi, q: String, page: Int, async: (ProductList) -> Unit) {
            api.getManga(q, page, async)
        }
    };

    abstract fun result(api: SearchApi, q: String, page: Int, async: (ProductList) -> Unit)
}

enum class ProductActions {
    SEARCH {
        override fun doing(api: SearchApi, q: ProductRequest, async: (ProductRequest) -> Unit) {

            q.firstPage = 1

            q.filter.result(api, q.query, q.firstPage) {
                q.firstPage = it.lastPage
                q.result = it.results
                async(q)
            }
        }
    },

    NEXT {
        override fun doing(api: SearchApi, q: ProductRequest, async: (ProductRequest) -> Unit) {
            q.filter.result(api, q.query, q.firstPage) {
                q.firstPage = it.lastPage
                q.result += it.results
                async(q)
            }
        }
    };

    abstract fun doing(api: SearchApi, q: ProductRequest, async: (ProductRequest) -> Unit)
}

data class ProductRequest(
        var query: String,
        var firstPage: Int,
        var filter: ProductType,
        var result: Array<Product>
)

class StoreProduct {

    private val subscribers = mutableSetOf<StoreSubscriber<Array<Product>>>()
    private val api: SearchApi = SearchApi()

    private var state: ProductRequest = ProductRequest("",
            1,
            ProductType.ANIME,
            emptyArray())
        set(value) {
            field = value
            subscribers.forEach { it(value.result) }
        }

    fun set(query: String) {
        state.query = query
    }

    fun set(filter: ProductType) {
        state.filter = filter
    }

    fun dispatch(action: ProductActions) {
        action.doing(api, state) {
            state = it
        }
    }

    fun add(subscriber: StoreSubscriber <Array<Product>>) = subscribers.add(element = subscriber)

    fun remove(subscriber: StoreSubscriber <Array<Product>>) = subscribers.remove(element = subscriber)
}