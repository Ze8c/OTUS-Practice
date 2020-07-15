package store

import kotlinx.coroutines.launch
import services.jikanAPI.SearchApi
import store.entity.ProductActions
import store.entity.ProductRequest
import store.entity.ProductType

class StoreProduct {

    val observer = StoreSubscriber()

    private val api: SearchApi = SearchApi()
    private val dispatch: Dispatch = Dispatch()
    private val scope: StoreCoroutineScope = StoreCoroutineScope(dispatch.defaultDispatcher)

    private var state: ProductRequest = ProductRequest("",
            1,
            ProductType.ANIME,
            emptyList())
        set(value) {
            field = value
            observer.set(result = value.result)
        }

    fun set(query: String) {
        state.query = query
    }

    fun set(filter: ProductType) {
        state.filter = filter
    }

    fun dispatch(action: ProductActions) {
        scope.launch {
            action.doing(api, state) {
                state = it
            }
        }
    }
}