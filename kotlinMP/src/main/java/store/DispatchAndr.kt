package store

import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import kotlin.coroutines.CoroutineContext

actual class Dispatch {

    actual val uiDispatcher: CoroutineContext
        get() = Dispatchers.Main

    actual val defaultDispatcher: CoroutineContext
        get() = Dispatchers.Default

    actual fun ktorScope(block: suspend () -> Unit) {
        GlobalScope.launch(Dispatchers.Main) { block() }
    }
}