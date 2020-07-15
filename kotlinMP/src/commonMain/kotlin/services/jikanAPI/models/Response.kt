package services.jikanAPI.models

class ContentResponse<T> {
    var content: T? = null
    var errorResponse: ErrorModel? = null
}