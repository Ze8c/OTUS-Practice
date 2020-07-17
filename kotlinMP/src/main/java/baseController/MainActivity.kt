package baseController

import adapters.MainHeader
import adapters.ProductTable
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import store.StoreProduct
import store.entity.ProductActions
import store.entity.ProductType

class MainActivity : AppCompatActivity() {

    private val header: MainHeader by lazy { MainHeader(this) }
    private val listProduct: RecyclerView by lazy { findViewById<RecyclerView>(R.id.product_list) }
    private val adapter: ProductTable by lazy { ProductTable() }

    private val store = StoreProduct()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContentView(R.layout.activity_main)

        listProduct.layoutManager = LinearLayoutManager(this)
        listProduct.adapter = adapter

        header.searchBtn.setOnClickListener {
            store.set("GTO")
            store.set(ProductType.ANIME)
            store.dispatch(ProductActions.SEARCH)
        }

        store.observer.add {
            GlobalScope.launch(Dispatchers.Main) {
                header.resultText.text = it.size.toString()
                adapter.update(it)
            }
        }
    }
}