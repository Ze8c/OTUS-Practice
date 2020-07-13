package services.jikanAPI.infrastructure

import io.ktor.client.*
import io.ktor.client.features.BrowserUserAgent
import io.ktor.client.features.CurlUserAgent
import io.ktor.client.features.UserAgent
import io.ktor.client.features.json.JsonFeature
import io.ktor.client.features.json.serializer.KotlinxSerializer
import io.ktor.client.request.*
import io.ktor.http.*
import kotlinx.coroutines.*
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.JsonConfiguration
import services.jikanAPI.models.Product

import services.jikanAPI.models.ProductList

expect val ApplicationDispatcher: CoroutineDispatcher

interface ApiConnector {
    fun request(config: RequestConfig, callback: (ProductList) -> Unit)
}

class ApiService : ApiConnector {

    private val baseUrl: String = "https://api.jikan.moe/v3"

    private val client = HttpClient() {

        install(UserAgent) {
            agent = "ktor"
        }

        install(JsonFeature) {
            val json = Json(JsonConfiguration(ignoreUnknownKeys = true))
            serializer = KotlinxSerializer(json)
        }

        BrowserUserAgent()

        CurlUserAgent()
    }

    override fun request(config: RequestConfig, callback: (ProductList) -> Unit) {

        GlobalScope.launch(ApplicationDispatcher) {
            val result = client.get<ProductList> {
                this.url {
                    this.takeFrom(URLBuilder(baseUrl))
                    appendPath(config.path.trimStart('/').split('/'))
                    config.query.forEach { elemnt ->
                        parameter(elemnt.key, elemnt.value)
                    }
                }

                this.method = config.method
            }

            callback(result)
        }
    }

    private fun URLBuilder.appendPath(components: List<String>): URLBuilder = apply {
        encodedPath = encodedPath
            .trimEnd('/') + components
            .joinToString("/", prefix = "/") { it.encodeURLQueryComponent() }
    }
}

class ApiStub : ApiConnector {

    override fun request(config: RequestConfig, callback: (ProductList) -> Unit) {
        GlobalScope.launch(ApplicationDispatcher) {

            val prod = Product(malId = 2001,
                    imageUrl = "",
                    title =  config.path,
                    synopsis = config.query.getValue("q"),
                    type = "anime",
                    members = 10,
                    score = 10.0)

            val prodA: Array<Product> = arrayOf(prod)
            val prodL = ProductList(1, prodA)
            callback(prodL)
        }
    }
}