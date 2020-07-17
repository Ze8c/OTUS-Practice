package adapters

import android.widget.Button
import android.widget.RelativeLayout
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import baseController.R

class MainHeader(val appActivity: AppCompatActivity) {

    private val mainView: RelativeLayout by lazy {
        appActivity.findViewById<RelativeLayout>(R.id.header_product)
    }

    val searchBtn: Button by lazy { mainView.findViewById<Button>(R.id.search_btn) }
    val resultText: TextView by lazy { mainView.findViewById<TextView>(R.id.count_product) }
}