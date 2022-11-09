package app.tankste.osm.model

data class LatLngModel(
    val latitude: Double,
    val longitude: Double,
) {

    fun toMap() = mapOf(
        "latitude" to latitude,
        "longitude" to longitude
    )

    companion object {

        fun fromMap(map: Map<String, Any>) = LatLngModel(
            latitude = (map["latitude"] as? Double) ?: 0.0,
            longitude = (map["longitude"] as? Double) ?: 0.0,
        )
    }
}
