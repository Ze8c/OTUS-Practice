/**
* Jikan
* Jikan
*
* The version of the OpenAPI document: 1.3.1
* 
*
* NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
* https://openapi-generator.tech
* Do not edit the class manually.
*/
package services.jikanAPI.models

import kotlinx.serialization.*

/**
 * 
 * @param lastPage 
 * @param results 
 */
@Serializable
data class ProductList (
    @SerialName(value = "last_page") val lastPage: Int,
    @SerialName(value = "results") val results: Array<Product>
)
