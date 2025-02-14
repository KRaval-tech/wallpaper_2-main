package com.wallpaper.wallpaper_2

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.widget.Button
import android.widget.ImageView
import android.widget.TextView
import com.google.android.gms.ads.nativead.MediaView
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin

class ListTileNativeAdFactory(var context: Context) : GoogleMobileAdsPlugin.NativeAdFactory {

    override fun createNativeAd(
        nativeAd: NativeAd,
        customOptions: MutableMap<String, Any>?
    ): NativeAdView {
        val nativeAdView = LayoutInflater.from(context)
            .inflate(R.layout.list_native_ad, null) as NativeAdView

        with(nativeAdView) {
            val attributionViewSmall =
                findViewById<TextView>(R.id.tv_list_tile_native_ad_attribution_small)
//            val attributionViewLarge =
//                findViewById<TextView>(R.id.tv_list_tile_native_ad_attribution_large)

            val iconView = findViewById<ImageView>(R.id.native_ad_icon)
            val icon = nativeAd.icon
            if (icon != null) {
                attributionViewSmall.visibility = View.VISIBLE
                //attributionViewLarge.visibility = View.INVISIBLE
                iconView.setImageDrawable(icon.drawable)
            } else {
                attributionViewSmall.visibility = View.INVISIBLE
                //attributionViewLarge.visibility = View.VISIBLE
            }
            this.iconView = iconView

            val mediaView = nativeAdView.findViewById<MediaView>(R.id.native_ad_media)
            mediaView.mediaContent = nativeAd.mediaContent
            this.mediaView = mediaView

            val headlineView = findViewById<TextView>(R.id.native_ad_headline)
            headlineView.text = nativeAd.headline
            this.headlineView = headlineView

            val bodyView = findViewById<TextView>(R.id.native_ad_body)
            with(bodyView) {
                text = nativeAd.body
                visibility = if (nativeAd.body?.isNotEmpty() == true) View.VISIBLE else View.INVISIBLE
            }
            this.bodyView = bodyView

            // Add Install Button
            val installButton = findViewById<Button>(R.id.native_ad_install_button)
            with(installButton) {
                text = nativeAd.callToAction
                visibility = if (nativeAd.callToAction?.isNotEmpty() == true) View.VISIBLE else View.INVISIBLE
            }
            this.callToActionView = installButton

            setNativeAd(nativeAd)
        }

        return nativeAdView
    }
}