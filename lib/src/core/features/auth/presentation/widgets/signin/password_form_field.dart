import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_colors.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_constants.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_dimensions.dart';
import 'package:smart_digital_wallet/src/core/common/extensions/sizes_extensions.dart';
import 'package:smart_digital_wallet/src/core/common/helper/regx.dart';
import 'package:smart_digital_wallet/src/core/common/localization/localization_service.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_strings.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/svg_image.dart';
import 'package:smart_digital_wallet/src/core/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:smart_digital_wallet/src/core/features/auth/presentation/widgets/signin/title_subtitle.dart';

class PasswordFormField extends StatelessWidget {
  final TextEditingController passwordController;
  const PasswordFormField({super.key, required this.passwordController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleSubtitle(
          title: context.translate(enterYourPassword),
          subtitle: context.translate(password),
        ),
        BlocBuilder<AuthBloc, AuthState>(
          buildWhen: (previous, current) =>
              previous.isPasswordVisible != current.isPasswordVisible,
          builder: (context, state) {
            return TextFormField(
              controller: passwordController,
              obscureText: !state.isPasswordVisible,
              decoration: InputDecoration(
                hintText: context.translate(passwordPlaceholder),
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
                suffixIcon: BlocBuilder<AuthBloc, AuthState>(
                  buildWhen: (previous, current) =>
                      previous.isPasswordVisible != current.isPasswordVisible,
                  builder: (context, state) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () {
                            context.read<AuthBloc>().add(
                              TogglePasswordVisibilityEvent(),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.all(
                              (AppDimensions.paddingSm + 4).width(context),
                            ),
                            child: SvgImage(
                              path: state.isPasswordVisible
                                  ? eyeOnImg
                                  : eyeOffImg,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            context.read<AuthBloc>().add(
                               AuthenticateWithBiometricsEvent(context),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.all(
                              (AppDimensions.paddingSm + 4).width(context),
                            ),
                            child: SvgImage(
                              path: biometricImg,
                              height: AppDimensions.iconMd,
                              width: AppDimensions.iconMd,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return context.translate(passwordRequired);
                } else if (!passwordReg.hasMatch(value)) {
                  return context.translate(invalidPassword);
                }
                return null;
              },
            );
          },
        ),
      ],
    );
  }
}
