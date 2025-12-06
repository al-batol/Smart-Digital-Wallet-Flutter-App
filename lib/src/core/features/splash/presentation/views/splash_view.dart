import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_colors.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_constants.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_dimensions.dart';
import 'package:smart_digital_wallet/src/core/common/extensions/sizes_extensions.dart';
import 'package:smart_digital_wallet/src/core/common/helper/svg_cache_helper.dart';
import 'package:smart_digital_wallet/src/core/common/routes/app_route_names.dart';
import 'package:smart_digital_wallet/src/core/features/splash/presentation/widgets/splash_footer_widget.dart';
import 'package:smart_digital_wallet/src/core/features/splash/presentation/widgets/splash_loading_widget.dart';
import 'package:smart_digital_wallet/src/core/features/splash/presentation/widgets/splash_logo_widget.dart';
import 'package:smart_digital_wallet/src/core/features/splash/presentation/widgets/splash_title_widget.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _pulseController;
  late Animation<double> _logoAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _initializeAndNavigate();
  }

  void _initializeAnimations() {
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _logoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _logoController, curve: Curves.easeIn));

    _logoController.forward();
    _pulseController.repeat(reverse: true);
  }

  Future<void> _initializeAndNavigate() async {
    try {
      await SvgCacheHelper.preCacheAllAssets(svgAssets);

      await Future.delayed(const Duration(seconds: 3));

      if (mounted) {
        context.go(starterRoute);
      }
    } catch (e) {
      debugPrint('Initialization failed: $e');
      if (mounted) {
        context.go(starterRoute);
      }
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [cardGradientStartColor, primaryColor, accentOrangeColor],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SplashLogoWidget(
                        logoAnimation: _logoAnimation,
                        pulseAnimation: _pulseAnimation,
                      ),
                      SizedBox(
                        height: AppDimensions.spacing3xl.height(context),
                      ),
                      SplashTitleWidget(animation: _logoAnimation),
                      SizedBox(
                        height: AppDimensions.spacing3xl.height(context),
                      ),
                      SplashLoadingWidget(animation: _logoAnimation),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: AppDimensions.paddingXl.height(context),
                ),
                child: SplashFooterWidget(animation: _fadeAnimation),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
