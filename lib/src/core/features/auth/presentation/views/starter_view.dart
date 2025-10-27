import 'package:flutter/material.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_constants.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/language_button.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/svg_image.dart';
import 'package:smart_digital_wallet/src/core/features/auth/presentation/widgets/starter/starter_content.dart';

class StarterView extends StatelessWidget {
  const StarterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Stack(
          children: [
            LanguageButton(),
            Row(
              children: [
                SvgImage(path: starterImg),
                Expanded(child: StarterContent()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
