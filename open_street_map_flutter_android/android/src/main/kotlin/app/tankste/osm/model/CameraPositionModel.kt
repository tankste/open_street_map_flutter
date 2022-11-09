package app.tankste.osm.model

data class CameraPositionModel(
    val center: LatLngModel,
    val zoom: Double,
) {

    fun toMap() = mapOf(
        "center" to center.toMap(),
        "zoom" to zoom
    )

    companion object {

        @Suppress("UNCHECKED_CAST")
        fun fromMap(map: Map<String, Any>) = CameraPositionModel(
            center = LatLngModel.fromMap(map["center"] as? Map<String, Any> ?: emptyMap()),
            zoom = (map["zoom"] as? Double) ?: 0.0
        )
    }
}
