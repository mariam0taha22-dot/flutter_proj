// lib/splash_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'home_page.dart'; // ينتقل تلقائياً للصفحة الرئيسية

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500), // وقت حركة ظهور الصورة
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 5.0).animate(_controller);
    _controller.forward();

    // الانتقال بعد 3 ثوانٍ إلى الصفحة الرئيسية (Home)
    Timer(const Duration(seconds: 6), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/splash_bg.png',
              ), // 👈 تأكدي من حفظ صورتكِ بهذا الاسم في مجلد الصور حقتكِ
              fit: BoxFit.cover, // لتغطية الشاشة كاملة بدقة عالية
            ),
          ),
        ),
      ),
    );
  }
}
