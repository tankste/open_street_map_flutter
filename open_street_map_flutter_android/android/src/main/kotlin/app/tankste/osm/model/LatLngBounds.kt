package app.tankste.osm.model

data class LatLngBoundsModel(
    val southwest: LatLngModel,
    val northeast: LatLngModel,
) {

    fun toMap() = mapOf(
        "southwest" to southwest.toMap(),
        "northeast" to northeast.toMap()
    )

    companion object {

        @Suppress("UNCHECKED_CAST")
        fun fromMap(map: Map<String, Any>) = LatLngBoundsModel(
            southwest = LatLngModel.fromMap(map["southwest"] as? Map<String, Any> ?: emptyMap()),
            northeast = LatLngModel.fromMap(map["northeast"] as? Map<String, Any> ?: emptyMap()),
        )
    }
}
