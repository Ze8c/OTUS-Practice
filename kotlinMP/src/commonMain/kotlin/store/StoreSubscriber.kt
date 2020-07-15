package store

import services.jikanAPI.models.Product

expect class StoreSubscriber {
    fun set(result: List<Product>)
    fun add(subscriber: (List<Product>) -> Unit)
    fun remove(subscriber: (List<Product>) -> Unit)
}