package app.tankste.osm.model

import android.graphics.Color
import androidx.annotation.ColorInt

data class PolylineModel(
    val id: String,
    val points: List<LatLngModel>,
    @ColorInt val color: Int,
    val width: Float,
) {

    companion object {

        @Suppress("UNCHECKED_CAST")
        fun fromMap(map: Map<String, Any>) = PolylineModel(
            id = (map["id"] as? String) ?: "",
            points = (map["points"] as? List<Map<String, Any>>)?.map { e -> LatLngModel.fromMap(e) }
                ?: emptyList(),
            color = (map["color"] as? Int) ?: Color.BLUE,
            width = (map["width"] as? Double)?.toFloat() ?: 0f,
        )
    }
}
