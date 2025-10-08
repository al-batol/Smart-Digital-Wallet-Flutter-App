import 'package:flutter/material.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_colors.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_dimensions.dart';
import 'package:smart_digital_wallet/src/core/common/extensions/sizes_extensions.dart';
import 'package:smart_digital_wallet/src/core/common/helper/responsive_helper.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/app_button.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/text_widget_xl.dart';
import 'package:smart_digital_wallet/src/core/features/auth/presentation/widgets/signin/email_form_field.dart';
import 'package:smart_digital_wallet/src/core/features/auth/presentation/widgets/signin/password_form_field.dart';
import 'package:smart_digital_wallet/src/core/features/auth/presentation/widgets/signin/security_header.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidgetXl(text: 'Sign In', textColor: textHeadlineColor),
        backgroundColor: primaryColor.withValues(alpha: 0.15),
      ),
      body: SafeArea(
        child: Form(
          child: Column(
            children: [
              const Expanded(flex: 2, child: SecurityHeader()),
              Expanded(
                flex: 3,
                child: Container(
                  width: ResponsiveHelper.screenWidth(context),
                  padding: EdgeInsets.all(
                    AppDimensions.paddingLg.width(context),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const EmailFormField(),
                        SizedBox(
                          height: AppDimensions.spacingMd.height(context),
                        ),
                        const PasswordFormField(),
                        const Spacer(),
                        AppButton(
                          text: 'Sign In',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {}
                          },
                        ),
                        SizedBox(
                          height: AppDimensions.spacingMd.height(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
