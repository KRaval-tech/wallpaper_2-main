// Separate Widget for Premium Alert Dialog
import 'package:flutter/material.dart';

class PremiumAlertDialog extends StatelessWidget {
  final String wallpaperUrl;
  final VoidCallback onWatchAd;
  final VoidCallback onGoPremium;

  const PremiumAlertDialog({
    Key? key,
    required this.wallpaperUrl,
    required this.onWatchAd,
    required this.onGoPremium,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(27),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CloseButton(),
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                wallpaperUrl,
                height: 256,
                width: 154,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text("Unlock this wallpaper", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text("Watch an ad to download this wallpaper for free, or subscribe to enjoy unlimited downloads.", textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onWatchAd,
              child: Text("Watch ADS"),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: onGoPremium,
              child: Text("Go Premium"),
            ),
          ],
        ),
      ),
    );
  }
}