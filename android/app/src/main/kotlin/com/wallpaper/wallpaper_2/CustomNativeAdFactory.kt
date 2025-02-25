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

class CustomNativeAdFactory(var context: Context) : GoogleMobileAdsPlugin.NativeAdFactory {
    override fun createNativeAd(
        nativeAd: NativeAd?,
        customOptions: MutableMap<String, Any>?
    ): NativeAdView {
        val adView = LayoutInflater.from(context).inflate(R.layout.native_full, null) as NativeAdView
//        val adOptions = NativeAdOptions.Builder()
//            .setMediaAspectRatio(MediaAspectRatio.PORTRAIT)
//            .build()
        // Set MediaView
        val mediaView = adView.findViewById<MediaView>(R.id.ad_media)
        adView.mediaView = mediaView
//        mediaView.setImageScaleType(ImageView.ScaleType.CENTER_CROP)

        // Set Ad Attribution Label
        adView.findViewById<TextView>(R.id.ad_attribution).apply {
            text = "Ad"
            visibility = View.VISIBLE
        }

        // Set Text Fields
        adView.headlineView = adView.findViewById<TextView>(R.id.ad_headline).apply {
            text = nativeAd?.headline
        }
        adView.bodyView = adView.findViewById<TextView>(R.id.ad_body).apply {
            text = nativeAd?.body ?: ""
        }

        // Set Icon (if available) with circular border
        val iconView = adView.findViewById<ImageView>(R.id.ad_app_icon)
        if (nativeAd?.icon != null) {
            iconView.setImageDrawable(nativeAd.icon?.drawable)
            adView.iconView = iconView
        } else {
            iconView.visibility = View.GONE
        }

        // Set CTA Button
        val ctaButton = adView.findViewById<Button>(R.id.ad_call_to_action)
        ctaButton.text = nativeAd?.callToAction
        adView.callToActionView = ctaButton

        // Assign the NativeAd object to the NativeAdView
        nativeAd?.let { adView.setNativeAd(it) }

        return adView
    }
}