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

import services.jikanAPI.models.ProductList

expect val ApplicationDispatcher: CoroutineDispatcher

class ApiService(private val baseUrl: String = "https://api.jikan.moe/v3") {

//    private val client = HttpClient()

    val client = HttpClient() {

        // Full configuration.
        install(UserAgent) {
            agent = "ktor"
        }

        install(JsonFeature) {
            serializer = KotlinxSerializer()
        }

        // Shortcut for the browser-like user agent.
        BrowserUserAgent()

        // Shortcut for the curl-like user agent.
        CurlUserAgent()
    }

    fun request(config: RequestConfig, callback: (ProductList) -> Unit) {

        GlobalScope.launch(ApplicationDispatcher) {
            val result: ProductList = client.get {
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