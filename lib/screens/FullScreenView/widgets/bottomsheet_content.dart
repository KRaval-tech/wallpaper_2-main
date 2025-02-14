// Separate Widget for Bottom Sheet Content
import 'package:flutter/material.dart';

class BottomSheetContent extends StatelessWidget {
  final dynamic wallpaper;
  final VoidCallback onSetAsLockScreen;
  final VoidCallback onSetAsHomeScreen;
  final VoidCallback onSetAsBoth;
  final VoidCallback onReport;

  const BottomSheetContent({
    Key? key,
    required this.wallpaper,
    required this.onSetAsLockScreen,
    required this.onSetAsHomeScreen,
    required this.onSetAsBoth,
    required this.onReport,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      height: 355,
      child: ListView(
        children: [
          ListTile(
            title: Text("Set as Lock Screen"),
            onTap: onSetAsLockScreen,
          ),
          ListTile(
            title: Text("Set as Home Screen"),
            onTap: onSetAsHomeScreen,
          ),
          ListTile(
            title: Text("Set as Both"),
            onTap: onSetAsBoth,
          ),
          ListTile(
            title: Text("Report this Photo"),
            onTap: onReport,
          ),
        ],
      ),
    );
  }
}