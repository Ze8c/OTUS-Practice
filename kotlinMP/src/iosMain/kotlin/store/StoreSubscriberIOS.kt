package store

import services.jikanAPI.models.Product

actual class StoreSubscriber {

    private val subscribers = mutableSetOf<(List<Product>) -> Unit>()

    actual fun set(result: List<Product>) = subscribers.forEach { it(result) }

    actual fun add(subscriber: (List<Product>) -> Unit) {
        subscribers.add(element = subscriber)
    }

    actual fun remove(subscriber: (List<Product>) -> Unit) {
        subscribers.remove(element = subscriber)
    }
}