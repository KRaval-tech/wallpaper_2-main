import 'package:flutter/material.dart';

class AvatarDetailPage extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const AvatarDetailPage({
    Key? key,
    required this.label,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(label),
        backgroundColor: color,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: color,
              child: Icon(icon, size: 50, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              label,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
