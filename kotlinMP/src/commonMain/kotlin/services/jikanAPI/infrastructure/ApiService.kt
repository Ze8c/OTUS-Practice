package services.jikanAPI.infrastructure

import io.ktor.client.*
import io.ktor.client.request.*
import io.ktor.http.*
import kotlinx.coroutines.*
import kotlinx.serialization.KSerializer
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.JsonConfiguration
import services.jikanAPI.models.ContentResponse
import services.jikanAPI.models.ErrorModel

import services.jikanAPI.models.ProductList
import store.Dispatch

//interface ApiConnector {
//    fun request(config: RequestConfig, callback: (ProductList) -> Unit)
//}
//
//class ApiService : ApiConnector {
//
//    private val baseUrl: String = "https://api.jikan.moe/v3"
//    private val dispatch: Dispatch = Dispatch()
//
//    private val client = HttpClient() {
//
//        install(UserAgent) {
//            agent = "ktor"
//        }
//
//        install(JsonFeature) {
//            val json = Json(JsonConfiguration(ignoreUnknownKeys = true))
//            serializer = KotlinxSerializer(json)
//        }
//
//        BrowserUserAgent()
//
//        CurlUserAgent()
//    }
//
//    override fun request(config: RequestConfig, callback: (ProductList) -> Unit) {
//
//        GlobalScope.launch(dispatch.defaultDispatcher) {
//            val result = client.get<ProductList> {
//                this.url {
//                    this.takeFrom(URLBuilder(baseUrl))
//                    appendPath(config.path.trimStart('/').split('/'))
//                    config.query.forEach { elemnt ->
//                        parameter(elemnt.key, elemnt.value)
//                    }
//                }
//
//                this.method = config.method
//            }
//
//            callback(result)
//        }
//    }
//
//    private fun URLBuilder.appendPath(components: List<String>): URLBuilder = apply {
//        encodedPath = encodedPath
//            .trimEnd('/') + components
//            .joinToString("/", prefix = "/") { it.encodeURLQueryComponent() }
//    }
//}

interface ApiConnector {
    suspend fun<T> getData(path: String, serializer: KSerializer<T>, completed: (T) -> Unit)
}

class ApiService : ApiConnector {

    private val httpClient = HttpClient()
    private val dispatch: Dispatch = Dispatch()
    private val baseHost: String = "api.jikan.moe"

    override suspend fun<T> getData(path: String, serializer: KSerializer<T>, completed: (T) -> Unit) {

        dispatch.ktorScope {

            var contentResponse = ContentResponse<T>()

            try {

                val json = httpClient.get<String> {
                    url {
                        protocol = URLProtocol.HTTPS
                        host = baseHost
                        encodedPath = path
                    }
                }
                print(json)
                val jsonConfig = Json(JsonConfiguration(ignoreUnknownKeys = true))
                val response = jsonConfig.parse(serializer, json)

                contentResponse.content = response

            } catch (ex: Exception) {
                val error = ErrorModel()
                error.message = ex.message.toString()
                contentResponse.errorResponse = error
                print(ex.message.toString())
            }

            withContext(dispatch.uiDispatcher) {
                contentResponse.content?.let { completed(it) }
            }
        }
    }
}

//class ApiStub : ApiConnector {
//
//    private val dispatch: Dispatch = Dispatch()
//
//    override fun request(config: RequestConfig, callback: (ProductList) -> Unit) {
//        GlobalScope.launch(dispatch.defaultDispatcher) {
//
//            val prod = Product(malId = 2001,
//                    imageUrl = "",
//                    title =  config.path,
//                    synopsis = config.query.getValue("q"),
//                    type = "anime",
//                    members = 10,
//                    score = 10.0)
//
//            val prodA: Array<Product> = arrayOf(prod)
//            val prodL = ProductList(1, prodA)
//            callback(prodL)
//        }
//    }
//}