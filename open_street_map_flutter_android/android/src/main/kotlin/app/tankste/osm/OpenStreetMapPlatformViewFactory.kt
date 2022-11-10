package app.tankste.osm

import android.content.Context
import app.tankste.osm.view.OpenStreetMapPlatformView
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class OpenStreetMapPlatformViewFactory(private val binaryMessenger: BinaryMessenger) :
    PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    @Suppress("UNCHECKED_CAST")
    override fun create(context: Context?, id: Int, arg: Any?): PlatformView {
        val argumentsMap = (arg as? Map<String, Any>) ?: emptyMap()
        val channelId = argumentsMap["channelId"] as? Int ?: 0
        //TODO: in which cases context is null?
        return OpenStreetMapPlatformView(context!!, channelId, binaryMessenger)
    }
}
