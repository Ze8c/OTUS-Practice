package store

import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Job
import kotlin.coroutines.CoroutineContext

class StoreCoroutineScope(
    context: CoroutineContext
) : CoroutineScope {

    private var job = Job()
    override val coroutineContext: CoroutineContext = context + job

    fun jobCancel() {
        job.cancel()
    }
}