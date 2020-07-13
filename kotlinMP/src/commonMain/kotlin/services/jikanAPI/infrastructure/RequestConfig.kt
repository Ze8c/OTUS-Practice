package services.jikanAPI.infrastructure

import io.ktor.http.HttpMethod

/**
 * Defines a config object for a given request.
 * NOTE: This object doesn't include 'body' because it
 *       allows for caching of the constructed object
 *       for many request definitions.
 * NOTE: Headers is a Map<String,String> because rfc2616 defines
 *       multi-valued headers as csv-only.
 */
data class RequestConfig(
    val method: HttpMethod,
    val path: String,
    val query: MutableMap<String, String> = mutableMapOf()
)