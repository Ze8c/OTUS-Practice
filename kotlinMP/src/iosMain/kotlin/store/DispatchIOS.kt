package store

import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.Runnable
import kotlinx.coroutines.launch
import platform.darwin.dispatch_async
import platform.darwin.dispatch_get_main_queue
import kotlin.coroutines.CoroutineContext
import kotlin.native.concurrent.freeze

actual class Dispatch {
    actual val uiDispatcher: CoroutineContext
        get() = MainDispatcher

    actual val defaultDispatcher: CoroutineContext
        get() = MainDispatcher

    actual fun ktorScope(block: suspend () -> Unit) {
        GlobalScope.launch(MainDispatcher) { block() }
    }
}


@ThreadLocal
private object MainDispatcher : CoroutineDispatcher() {

    override fun dispatch(context: CoroutineContext, block: Runnable) {
        dispatch_async(dispatch_get_main_queue()) {
            try {
                block.run().freeze()
            } catch (err: Throwable) {
                throw err
            }
        }
    }
}