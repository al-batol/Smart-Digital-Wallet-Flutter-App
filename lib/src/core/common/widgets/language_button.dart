import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_constants.dart'
    show appLanguages;
import 'package:smart_digital_wallet/src/core/common/constants/app_dimensions.dart';
import 'package:smart_digital_wallet/src/core/common/extensions/sizes_extensions.dart';
import 'package:smart_digital_wallet/src/core/common/localization/cubit/localization_cubit.dart';

class LanguageButton extends StatelessWidget {
  final bool isDashboard;
  const LanguageButton({super.key, this.isDashboard = false});

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    IconButton buildLanguageButton() {
      return IconButton(
        onPressed: () {
          context.read<LocalizationCubit>().changeAppLanguage(
            isArabic ? appLanguages[0] : appLanguages[1],
          );
        },
        icon: Icon(Icons.language, size: AppDimensions.iconLg.width(context)),
      );
    }

    return isDashboard
        ? buildLanguageButton()
        : Positioned(
            top: 0,
            right: isArabic ? null : 0,
            left: isArabic ? 0 : null,
            child: buildLanguageButton(),
          );
  }
}
