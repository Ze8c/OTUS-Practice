package store

import io.ktor.client.features.json.serializer.KotlinxSerializer
import io.ktor.http.content.MultiPartData
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.launch
import services.jikanAPI.SearchApi
import services.jikanAPI.models.Product
import services.jikanAPI.models.ProductList
import kotlin.coroutines.CoroutineContext

enum class ProductActions { SEARCH, UPDATE, NEXT }

val CounterStateReducer: Reducer<ProductList, ProductActions> = { old, action ->
    when (action) {
        ProductActions.SEARCH -> old
        ProductActions.UPDATE -> old
        ProductActions.NEXT -> old
    }
}

final class StoreProduct(
    initialState: ProductList = ProductList(0, emptyArray()),
    private val reducer: Reducer<ProductList, ProductActions> = CounterStateReducer
) : CoroutineScope {

    private var job: Job = Job()

    override val coroutineContext: CoroutineContext
        get() = Dispatchers.Main + job

    private val subscribers = mutableSetOf<StoreSubscriber<ProductList>>()

    private var state: ProductList = initialState
        set(value) {
            field = value
            subscribers.forEach { it(value) }
        }

    fun getJob() = job

    fun dispatch(action: ProductActions) {
        state = reducer(state, action)
    }

    fun add(subscriber: StoreSubscriber <ProductList>) = subscribers.add(element = subscriber)

    fun remove(subscriber: StoreSubscriber <ProductList>) = subscribers.remove(element = subscriber)

    fun search(q: String, page: Int) {
        val apiInstance = SearchApi()
        launch { state = apiInstance.getAnime(q, page) }
    }

    fun testSearch() {
        state = ProductList(20, emptyArray())
    }
}