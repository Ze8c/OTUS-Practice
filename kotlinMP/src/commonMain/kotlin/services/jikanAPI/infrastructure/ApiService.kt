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
import services.jikanAPI.models.Product
import services.jikanAPI.models.ProductList

import store.Dispatch

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

class ApiStub : ApiConnector {

    private val dispatch: Dispatch = Dispatch()

    override suspend fun<T> getData(path: String, serializer: KSerializer<T>, completed: (T) -> Unit) {

        dispatch.ktorScope {

            var contentResponse = ContentResponse<T>()

            val imgURL = "https://cdn.myanimelist.net/images/anime/13/11460.jpg?s=7e890b7e93b7b57c2de4aa90211931bd"

            val prod = Product(
                245,
                imgURL,
                "Great Teacher Onizuka",
                "Onizuka is a reformed biker gang leader who has his sights set on an honorable new ambition...",
                "Anime",
            476501,
            8.71)

            contentResponse.content = ProductList(3, listOf(prod, prod)) as T

            withContext(dispatch.uiDispatcher) {
                contentResponse.content?.let { completed(it) }
            }
        }
    }
}