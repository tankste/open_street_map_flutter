package app.tankste.osm.model

data class MarkerModel(
    val id: String,
    val point: LatLngModel,
    val iconBytes: ByteArray?,
) {

    companion object {

        @Suppress("UNCHECKED_CAST")
        fun fromMap(map: Map<String, Any>) = MarkerModel(
            id = (map["id"] as? String) ?: "",
            point = LatLngModel.fromMap(map["point"] as? Map<String, Any> ?: emptyMap()),
            iconBytes = (map["icon"] as? ByteArray)
        )
    }

    override fun equals(other: Any?): Boolean {
        if (this === other) return true
        if (javaClass != other?.javaClass) return false

        other as MarkerModel

        if (id != other.id) return false
        if (point != other.point) return false

        return true
    }

    override fun hashCode(): Int {
        var result = id.hashCode()
        result = 31 * result + point.hashCode()
        return result
    }
}
