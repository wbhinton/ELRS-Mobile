import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _animationController.forward();

    // Navigate to dashboard after 3 seconds
    _navigationTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        context.go('/dashboard');
      }
    });
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildLogo() {
    return const SizedBox(
      height: 180,
      width: 180,
      // TODO: Replace with custom Logo Asset.
      child: Center(
        child: Icon(
          Icons.settings_input_antenna,
          size: 120,
          color: Color(0xFF00E5FF), // Electric Cyan
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E1E1E), Color(0xFF121212)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            children: [
              // Top (Flex 2): Empty space for balance.
              const Spacer(flex: 2),

              // Center (Flex 3)
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLogo(),
                    const SizedBox(height: 24),
                    // App Name
                    Text(
                      'ELRS Mobile', // Or 'ELRS Manager'
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontFamily: 'Roboto', // Replace with desired sans-serif if needed
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
                    // Tagline
                    Text(
                      'INDEPENDENT CONFIGURATION TOOL',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: const Color(0xFF02569B), // Flutter Blue
                        letterSpacing: 2.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              // Bottom (Flex 1)
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Loading Indicator
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 64.0),
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.black26,
                        color: Color(0xFF00E5FF),
                        minHeight: 2,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Legal Disclaimer
                    const Text(
                      'Not an official ExpressLRS product.\nCompatible with 3.x/4.x firmware.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // Version Info in the corner
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: const Padding(
        padding: EdgeInsets.only(top: 16.0),
        child: Text(
          'v1.0.0-beta',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}
