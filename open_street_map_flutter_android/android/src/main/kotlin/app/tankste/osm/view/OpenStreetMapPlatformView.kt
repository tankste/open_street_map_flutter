package app.tankste.osm.view

import android.content.Context
import android.graphics.BitmapFactory
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import android.util.Log
import android.view.View
import app.tankste.osm.model.CameraPositionModel
import app.tankste.osm.model.LatLngModel
import app.tankste.osm.model.MarkerModel
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView
import org.osmdroid.config.Configuration
import org.osmdroid.events.MapListener
import org.osmdroid.events.ScrollEvent
import org.osmdroid.events.ZoomEvent
import org.osmdroid.util.GeoPoint
import org.osmdroid.views.CustomZoomButtonsController
import org.osmdroid.views.MapView
import org.osmdroid.views.overlay.Marker


class OpenStreetMapPlatformView(private val context: Context, binaryMessenger: BinaryMessenger) :
    PlatformView,
    MethodChannel.MethodCallHandler {

    private val methodChannel = MethodChannel(
        binaryMessenger,
        "app.tankste.osm/open_street_map_flutter_android"
    ).apply {
        Log.d("debug", "INIT channel")
        setMethodCallHandler(this@OpenStreetMapPlatformView)
    }

    private val mapView = MapView(context).apply {
        //TODO: make this configurable
        zoomController.setVisibility(CustomZoomButtonsController.Visibility.NEVER)
        addMapListener(object : MapListener {
            override fun onScroll(event: ScrollEvent): Boolean {
                //TODO: notify for
                //  1. Camera move started
                //  2. Camera moving
                //  3. Camera idle
                notifyNewCameraPosition()
                return false
            }

            override fun onZoom(event: ZoomEvent): Boolean {
                //TODO: notify for
                //  1. Camera move started
                //  2. Camera moving
                //  3. Camera idle
                notifyNewCameraPosition()
                return false
            }
        })
    }

    init {
        //TODO: get this from params or app settings
        // this should set by client of library not by the library itself
        Configuration.getInstance().userAgentValue = "app.tankste.osm"
        methodChannel.toString()
    }

    override fun getView(): View = mapView

    override fun dispose() {

    }

    override fun onMethodCall(methodCall: MethodCall, result: MethodChannel.Result) {
        when (methodCall.method) {
            "style#set" ->
                setMapStyle(methodCall, result)
            "camera#set" ->
                setCamera(methodCall, result)
            "camera#move" ->
                moveCamera(methodCall, result)
            "markers#set" ->
                setMarkers(methodCall, result)
            "polylines#set" ->
                setPolylines(methodCall, result)
        }
    }

    private fun setMapStyle(methodCall: MethodCall, result: MethodChannel.Result) {

    }

    private fun setCamera(methodCall: MethodCall, result: MethodChannel.Result) {
        val cameraPositionMap = methodCall.argument<Map<String, Any>>("cameraPosition") ?: emptyMap()
        val cameraPosition = CameraPositionModel.fromMap(cameraPositionMap)

        mapView.controller.setCenter(
            GeoPoint(
                cameraPosition.center.latitude,
                cameraPosition.center.longitude
            )
        )
        mapView.controller.setZoom(cameraPosition.zoom)

        result.success(null)
    }

    private fun moveCamera(methodCall: MethodCall, result: MethodChannel.Result) {

    }

    private fun setMarkers(methodCall: MethodCall, result: MethodChannel.Result) {
        val markersList = methodCall.argument<List<Map<String, Any>>>("markers") ?: emptyList()
        val osmMarkers = markersList.map(MarkerModel::fromMap)
            .map { marker ->
                Marker(mapView).apply {
                    id = marker.id
                    position = GeoPoint(marker.point.latitude, marker.point.longitude)

                    marker.iconBytes?.let { iconBytes ->
                        val icon: Drawable = BitmapDrawable(
                            context.resources,
                            BitmapFactory.decodeByteArray(
                                iconBytes,
                                0,
                                iconBytes.size
                            )
                        )
                        setIcon(icon)
                    }
                }
            }

        mapView.overlays.clear()
        mapView.overlays.addAll(osmMarkers);

//
//        val startMarker = Marker(mapView)
//        startMarker.position = startPoint
//        startMarker.setAnchor(Marker.ANCHOR_CENTER, Marker.ANCHOR_BOTTOM)
//        mapView.overlays.add(startMarker)

        result.success(null)
    }

    private fun setPolylines(methodCall: MethodCall, result: MethodChannel.Result) {

    }

    private fun notifyNewCameraPosition() {
        methodChannel.invokeMethod(
            "camera#moved", CameraPositionModel(
                center = LatLngModel(mapView.mapCenter.latitude, mapView.mapCenter.longitude),
                zoom = mapView.zoomLevelDouble,
            ).toMap()
        )
    }
}
