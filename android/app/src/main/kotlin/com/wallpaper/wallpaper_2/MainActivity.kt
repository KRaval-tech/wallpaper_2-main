package com.wallpaper.wallpaper_2

import android.app.WallpaperManager
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.os.Build
import androidx.annotation.NonNull
import com.google.android.gms.ads.MediaAspectRatio
import com.google.android.gms.ads.nativead.NativeAdOptions
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.KeyData.CHANNEL
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import java.net.URL

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.wallpaper.wallpaper_2"

    override
    fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "setWallpaper" -> {
                    val type = call.argument<String>("type") ?: ""
                    val imageUrl = call.argument<String>("imageUrl") ?: ""
                    setWallpaper(type, imageUrl, result)
                }
                "reportWallpaper" -> {
                    val imageUrl = call.argument<String>("imageUrl") ?: ""
                    reportWallpaper(imageUrl, result)
                }
                else -> result.notImplemented()
            }
        }

        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine,"videoNativeAd", ListTileNativeAdFactory(context))
        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "full_native", CustomNativeAdFactory(context))

        // Configure NativeAdOptions with portrait aspect ratio
        val adOptions = NativeAdOptions.Builder()
            .setMediaAspectRatio(MediaAspectRatio.PORTRAIT)
            .build()
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        super.cleanUpFlutterEngine(flutterEngine)

        // TODO: Unregister the ListTileNativeAdFactory
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "videoNativeAd")
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "full_native")

    }

    private fun setWallpaper(type: String, imageUrl: String, result: MethodChannel.Result) {
        CoroutineScope(Dispatchers.IO).launch {
            try {
                val url = URL(imageUrl)
                val bitmap = BitmapFactory.decodeStream(url.openConnection().getInputStream())
                val wallpaperManager = WallpaperManager.getInstance(applicationContext)

                when (type) {
                    "lock" -> {
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                            wallpaperManager.setBitmap(bitmap, null, true, WallpaperManager.FLAG_LOCK)
                        } else {
                            result.error("UNSUPPORTED", "Lock screen wallpaper not supported on this device", null)
                            return@launch
                        }
                    }
                    "home" -> {
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                            wallpaperManager.setBitmap(bitmap, null, true, WallpaperManager.FLAG_SYSTEM)
                        } else {
                            wallpaperManager.setBitmap(bitmap) // Older devices ke liye
                        }
                    }
                    "both" -> {
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                            wallpaperManager.setBitmap(bitmap, null, true, WallpaperManager.FLAG_LOCK)
                            wallpaperManager.setBitmap(bitmap, null, true, WallpaperManager.FLAG_SYSTEM)
                        } else {
                            wallpaperManager.setBitmap(bitmap) // Older devices ke liye
                        }
                    }
                }
                result.success("Wallpaper set successfully")
            } catch (e: Exception) {
                result.error("ERROR", "Failed to set wallpaper: ${e.message}", null)
            }
        }
    }




    private fun reportWallpaper(imageUrl: String, result: MethodChannel.Result) {
        // Simulate reporting functionality
        // You can send the `imageUrl` to your backend server for reporting
        result.success("Wallpaper reported successfully: $imageUrl")
    }
}
