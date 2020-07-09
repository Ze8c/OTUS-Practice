package services.jikanAPI.infrastructure

import io.ktor.client.call.TypeInfo
import io.ktor.client.call.typeInfo
import io.ktor.client.statement.*
import io.ktor.http.Headers
import io.ktor.http.isSuccess

open class HttpResp<T : Any>(val response: HttpResponse, val provider: BodyProvider<T>) {
    val status: Int = response.status.value
    val success: Boolean = response.status.isSuccess()
    val headers: Map<String, List<String>> = response.headers.mapEntries()
    suspend fun body(): T = provider.body(response)
    suspend fun <V : Any> typedBody(type: TypeInfo): V = provider.typedBody(response, type)

    companion object {
        private fun Headers.mapEntries(): Map<String, List<String>> {
            val result = mutableMapOf<String, List<String>>()
            entries().forEach { result[it.key] = it.value }
            return result
        }
    }
}

interface BodyProvider<T : Any> {
    suspend fun body(response: HttpResponse): T
    suspend fun <V : Any> typedBody(response: HttpResponse, type: TypeInfo): V
}

class TypedBodyProvider<T : Any>(private val type: TypeInfo) : BodyProvider<T> {
    @Suppress("UNCHECKED_CAST")
    override suspend fun body(response: HttpResponse): T =
            response.call.receive(type) as T

    @Suppress("UNCHECKED_CAST")
    override suspend fun <V : Any> typedBody(response: HttpResponse, type: TypeInfo): V =
            response.call.receive(type) as V
}

class MappedBodyProvider<S : Any, T : Any>(private val provider: BodyProvider<S>, private val block: S.() -> T) : BodyProvider<T> {
    override suspend fun body(response: HttpResponse): T =
            block(provider.body(response))

    override suspend fun <V : Any> typedBody(response: HttpResponse, type: TypeInfo): V =
            provider.typedBody(response, type)
}

inline fun <reified T : Any> HttpResponse.wrap(): HttpResp<T> =
        HttpResp(this, TypedBodyProvider(typeInfo<T>()))

fun <T : Any, V : Any> HttpResp<T>.map(block: T.() -> V): HttpResp<V> =
        HttpResp(response, MappedBodyProvider(provider, block))
