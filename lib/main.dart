// lib/main.dart
import 'package:flutter/material.dart';
import 'splash_screen.dart';

void main() {
  runApp(const MiniMarketplaceApp());
}

class MiniMarketplaceApp extends StatelessWidget {
  const MiniMarketplaceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Marketplace',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(fontFamily: 'Almarai'),

      home: const SplashScreen(), // الصفحة التي تبدأ عند فتح التطبيق
    );
  }
}
