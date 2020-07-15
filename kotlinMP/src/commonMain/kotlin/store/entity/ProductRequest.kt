package store.entity

import services.jikanAPI.models.Product

data class ProductRequest(
    var query: String,
    var firstPage: Int,
    var filter: ProductType,
    var result: List<Product>
)