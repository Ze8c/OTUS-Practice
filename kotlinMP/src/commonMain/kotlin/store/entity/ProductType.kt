package store.entity

import services.jikanAPI.SearchApi
import services.jikanAPI.models.ContentResponse
import services.jikanAPI.models.ProductList

enum class ProductType {
    ANIME {
        override suspend fun result(api: SearchApi, q: String, page: Int, async: (ProductList) -> Unit) {
            api.getAnime(q, page, async)
        }
    },

    MANGA {
        override suspend fun result(api: SearchApi, q: String, page: Int, async: (ProductList) -> Unit) {
            api.getManga(q, page, async)
        }
    };

    abstract suspend fun result(api: SearchApi, q: String, page: Int, async: (ProductList) -> Unit)
}