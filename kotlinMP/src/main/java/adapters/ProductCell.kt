package adapters

import Core.extensions.loadImage
import android.view.LayoutInflater
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView

import baseController.R
import services.jikanAPI.models.Product

class ProductCell(inflater: LayoutInflater,
                     container: ViewGroup
) : RecyclerView.ViewHolder(inflater.inflate(R.layout.product_cell, container, false)) {

    private val image by lazy { itemView.findViewById<ImageView>(R.id.icon_product) }
    private val title by lazy { itemView.findViewById<TextView>(R.id.title_product) }
    private val summary by lazy { itemView.findViewById<TextView>(R.id.summary_product) }

    var tag: Int = 0

    fun bindItem(item: Product) {
        summary.text = "Members: ${item.members}  Rating: ${item.score}"
        image.loadImage(item.imageUrl)
        title.text = item.title
    }

}