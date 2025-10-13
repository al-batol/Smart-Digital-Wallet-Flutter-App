import 'package:flutter/material.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_colors.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_dimensions.dart';
import 'package:smart_digital_wallet/src/core/common/extensions/sizes_extensions.dart';
import 'package:smart_digital_wallet/src/core/common/helper/regx.dart';
import 'package:smart_digital_wallet/src/core/features/auth/presentation/widgets/signin/title_subtitle.dart';

class EmailFormField extends StatelessWidget {
  final TextEditingController emailController;
  const EmailFormField({super.key, required this.emailController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleSubtitle(title: 'Enter Your Email', subtitle: 'Email'),
        TextFormField(
          controller: emailController,
          decoration: InputDecoration(
            hintText: 'example@domain.com',
            hintStyle: TextStyle(color: hintTextFieldColor),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: textHeadlineColor.withValues(alpha: 0.2),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: textHeadlineColor.withValues(alpha: 0.2),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: textHeadlineColor.withValues(alpha: 0.2),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: errorTextColor.withValues(alpha: 0.2),
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: textHeadlineColor.withValues(alpha: 0.2),
              ),
            ),
            contentPadding: EdgeInsets.all(
              AppDimensions.paddingSm.width(context),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Email is required';
            } else if (!emailReg.hasMatch(value)) {
              return 'Invalid email';
            }
            return null;
          },
        ),
      ],
    );
  }
}
