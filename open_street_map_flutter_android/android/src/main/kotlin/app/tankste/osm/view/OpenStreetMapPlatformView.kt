package app.tankste.osm.view

import android.R.id
import android.content.Context
import android.view.View
import android.view.ViewGroup
import io.flutter.BuildConfig
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView
import org.osmdroid.config.Configuration
import org.osmdroid.views.MapView


class OpenStreetMapPlatformView(context: Context, binaryMessenger: BinaryMessenger) : PlatformView,
    MethodChannel.MethodCallHandler {

    private val mapView = MapView(context)

    private val methodChannel = MethodChannel(
        binaryMessenger,
        "app.tankste.osm/open_street_map_flutter_android"
    ).apply {
        setMethodCallHandler(this@OpenStreetMapPlatformView)
    }

    init {
        //TODO: get this from params or app settings
        // this should set by client of library not by the library itself
        Configuration.getInstance().userAgentValue = "app.tankste.osm"


    }

    override fun getView(): View = mapView

    override fun dispose() {

    }

    override fun onMethodCall(methodCall: MethodCall, result: MethodChannel.Result) {
        result.success(null)
    }
}
