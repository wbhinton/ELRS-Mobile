import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  Timer? _navigationTimer;
  String _version = '';

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _animationController.forward();

    // Navigate to dashboard after 3 seconds
    _navigationTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        context.go('/dashboard');
      }
    });

    _initVersion();
  }

  Future<void> _initVersion() async {
    final info = await PackageInfo.fromPlatform();
    if (mounted) {
      setState(() {
        _version = 'v${info.version}';
      });
    }
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildLogo() {
    return SvgPicture.asset(
      'icons/elrs_mobile_foreground.svg',
      height: 180,
      width: 180,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E1E1E), Color(0xFF121212)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: OrientationBuilder(
              builder: (context, orientation) {
                // 1. LANDSCAPE LAYOUT (For AX12 Tablet)
                if (orientation == Orientation.landscape) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Left Side: Scaled-down Logo
                      SvgPicture.asset(
                        'icons/elrs_mobile_foreground.svg',
                        height: 120, // Smaller to fit landscape height
                        width: 120,
                      ),
                      const SizedBox(width: 48),
                      // Right Side: Loading and Text
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ELRS Mobile',
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  letterSpacing: 1.2,
                                  shadows: [
                                    const Shadow(
                                      color: Color(0xFF00E5FF),
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'INDEPENDENT CONFIGURATION TOOL',
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: const Color(0xFF02569B),
                                  letterSpacing: 2.5,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(height: 24),
                          const SizedBox(
                            width: 200,
                            child: LinearProgressIndicator(
                              backgroundColor: Colors.black26,
                              color: Color(0xFF00E5FF),
                              minHeight: 2,
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'Not an official ExpressLRS product.\nCompatible with 3.3.x/4.x firmware.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey, fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  );
                }

                // 2. STANDARD PORTRAIT LAYOUT (For Smartphones)
                return Column(
                  children: [
                    const Spacer(flex: 2),
                    _buildLogo(),
                    const SizedBox(height: 24),
                    Text(
                      'ELRS Mobile',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: 1.2,
                            shadows: [
                              const Shadow(
                                color: Color(0xFF00E5FF),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'INDEPENDENT CONFIGURATION TOOL',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: const Color(0xFF02569B),
                        letterSpacing: 2.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(flex: 2),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 64.0),
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.black26,
                        color: Color(0xFF00E5FF),
                        minHeight: 2,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Not an official ExpressLRS product.\nCompatible with 3.3.x/4.x firmware.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Text(
          _version,
          style: const TextStyle(color: Colors.grey, fontSize: 10),
        ),
      ),
    );
  }
}
