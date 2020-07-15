package baseController

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.TextView
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import sample.R
import store.StoreProduct
import store.entity.ProductActions
import store.entity.ProductType

class MainActivity : AppCompatActivity() {

    private val searchBtn by lazy { findViewById<Button>(R.id.search_button) }
    private val resultText by lazy { findViewById<TextView>(R.id.text_test) }

    private val store = StoreProduct()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContentView(R.layout.activity_main)

        searchBtn.setOnClickListener {
            store.set("GTO")
            store.set(ProductType.ANIME)
            store.dispatch(ProductActions.SEARCH)
        }

        store.observer.add {
            GlobalScope.launch(Dispatchers.Main) {
                resultText.text = it.size.toString()
            }
        }
    }
}