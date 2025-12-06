import 'package:flutter/material.dart';
import 'package:smart_digital_wallet/src/core/common/localization/localization_service.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/text_widget_3xl.dart';

class SplashTitleWidget extends StatelessWidget {
  final Animation<double> animation;

  const SplashTitleWidget({super.key, required this.animation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.scale(
          scale: animation.value,
          child: Column(
            children: [
              TextWidget3xl(
                text: context.translate('smart_digital_wallet'),
                textColor: Colors.white,
              ),
            ],
          ),
        );
      },
    );
  }
}
