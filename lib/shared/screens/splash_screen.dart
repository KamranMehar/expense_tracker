import 'package:expense_tracker/core/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../core/router/routes_names.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _logoSize = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _logoSize = 300;
      });
    });
    initializeApp();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, // Transparent status bar for Android
          statusBarIconBrightness: Brightness.dark, // Dark icons for light backgrounds (Android)
          statusBarBrightness: Brightness.light, // Dark icons for light backgrounds (iOS)
        )
      ),
      body: Center(
        child: AnimatedContainer(
          duration: const Duration(seconds: 3),
          width: _logoSize,
          height: _logoSize,
          child: Image.asset(AppAssets.logo),
        ),
      ),
    );
  }

  void initializeApp()async {
    await Future.delayed(const Duration(seconds: 3));
    context.goNamed(RoutesNames.home);
  }
}
