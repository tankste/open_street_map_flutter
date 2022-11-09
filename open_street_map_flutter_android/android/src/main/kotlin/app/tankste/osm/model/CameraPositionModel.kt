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

//        @Suppress("UNCHECKED_CAST")
//        fun fromMap(map: Map<String, Any>) = CameraPositionModel(
//            id = (map["id"] as? String) ?: "",
//            point = LatLngModel.fromMap(map["point"] as? Map<String, Any> ?: emptyMap()),
//            iconBytes = (map["icon"] as? ByteArray)
//        )
    }
}
