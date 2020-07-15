package store

import kotlin.coroutines.CoroutineContext

expect class Dispatch {
    val defaultDispatcher: CoroutineContext
    val uiDispatcher: CoroutineContext
    fun ktorScope(block: suspend () -> Unit)
}