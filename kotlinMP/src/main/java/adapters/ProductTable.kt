package adapters

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import services.jikanAPI.models.Product

class ProductTable: RecyclerView.Adapter<ProductCell>() {

    var items: ArrayList<Product> = arrayListOf()

    fun update(data: List<Product>){
        items = arrayListOf()
        items.addAll(data)
        notifyDataSetChanged()
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ProductCell {
        return ProductCell(LayoutInflater.from(parent.context), parent)
    }

    override fun getItemCount(): Int {
        return items.count()
    }

    override fun onBindViewHolder(holder: ProductCell, position: Int) {
        items[position].let {
            holder.tag = position
            holder.bindItem(it)
        }
    }
}