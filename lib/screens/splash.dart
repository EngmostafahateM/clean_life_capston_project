import 'dart:async';
import 'package:clean_life_capston_project/Screens/loginscreen.dart';
import 'package:flutter/material.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/constants_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(const Duration(seconds: AppConstants.splashDelay), _goNext);
  }

  _goNext() {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => Loginscreen()));
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body:
      const Center(child: Image(image: AssetImage(ImageAssets.splashLogo))),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}