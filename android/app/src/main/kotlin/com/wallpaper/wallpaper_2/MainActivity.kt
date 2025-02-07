package com.wallpaper.wallpaper_2

import android.app.WallpaperManager
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.os.Build
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
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
                        wallpaperManager.setBitmap(bitmap)
                    }
                    "both" -> {
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                            wallpaperManager.setBitmap(bitmap, null, true, WallpaperManager.FLAG_LOCK)
                        }
                        wallpaperManager.setBitmap(bitmap)
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
