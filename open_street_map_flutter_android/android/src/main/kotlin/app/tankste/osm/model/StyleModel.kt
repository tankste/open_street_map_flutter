package app.tankste.osm.model

data class StyleModel(
    val invertColors: Boolean,
) {

    fun toMap() = mapOf(
        "invertColors" to invertColors,
    )

    companion object {

        fun fromMap(map: Map<String, Any>) = StyleModel(
            invertColors = (map["invertColors"] as? Boolean) ?: false,
        )
    }
}
