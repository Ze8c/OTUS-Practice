package services.jikanAPI.infrastructure

import kotlinx.coroutines.*

actual val ApplicationDispatcher: CoroutineDispatcher = Dispatchers.Default