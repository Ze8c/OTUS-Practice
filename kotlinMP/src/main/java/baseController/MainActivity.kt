package baseController

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.TextView
import sample.R
import store.StoreProduct

class MainActivity : AppCompatActivity() {

    private val searchBtn by lazy { findViewById<Button>(R.id.search_button) }
    private val searchField by lazy {
        findViewById<com.google.android.material.textfield.TextInputLayout>(R.id.search_field)
    }

    private val resultText by lazy { findViewById<TextView>(R.id.text_test) }

    private val store = StoreProduct()

    override fun onDestroy() {
        super.onDestroy()
        store.getJob().cancel()
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContentView(R.layout.activity_main)

        searchBtn.setOnClickListener {
            resultText.text = searchField.toString()
//            store.search("GTO", 0)
            store.testSearch()
        }

        store.add {
            resultText.text = it.lastPage.toString()
        }
    }
}