import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_colors.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_constants.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_dimensions.dart';
import 'package:smart_digital_wallet/src/core/common/extensions/sizes_extensions.dart';
import 'package:smart_digital_wallet/src/core/common/helper/regx.dart';
import 'package:smart_digital_wallet/src/core/common/helper/responsive_helper.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/app_button.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/svg_image.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/text_widget_sm.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/text_widget_xl.dart';
import 'package:smart_digital_wallet/src/core/features/auth/presentation/bloc/bloc/auth_bloc.dart';

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
              Expanded(
                flex: 2,
                child: Container(
                  width: ResponsiveHelper.screenWidth(context),
                  color: primaryColor.withValues(alpha: 0.15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: AppDimensions.spacingSm.spacing(context),
                    children: [
                      SvgImage(
                        path: securityImg,
                        height: 178,
                        width: 143,
                        fit: BoxFit.contain,
                      ),
                      SvgImage(
                        path: shadowCircleImg,
                        height: 8,
                        width: 156,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
              ),
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
                        TextWidgetXl(
                          text: 'Enter Your Email',
                          textColor: textHeadlineColor,
                        ),
                        SizedBox(
                          height: AppDimensions.spacingMd.height(context),
                        ),
                        TextWidgetSm(
                          text: 'Email',
                          textColor: textHeadlineColor,
                        ),
                        SizedBox(
                          height: AppDimensions.spacingXs.height(context),
                        ),
                        TextFormField(
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
                        SizedBox(
                          height: AppDimensions.spacingMd.height(context),
                        ),
                        TextWidgetXl(
                          text: 'Enter Your Password',
                          textColor: textHeadlineColor,
                        ),
                        SizedBox(
                          height: AppDimensions.spacingMd.height(context),
                        ),
                        TextWidgetSm(
                          text: 'Password',
                          textColor: textHeadlineColor,
                        ),
                        SizedBox(
                          height: AppDimensions.spacingXs.height(context),
                        ),
                        BlocBuilder<AuthBloc, AuthState>(
                          buildWhen: (previous, current) =>
                              previous.isPasswordVisible !=
                              current.isPasswordVisible,
                          builder: (context, state) {
                            return TextFormField(
                              obscureText: !state.isPasswordVisible,
                              decoration: InputDecoration(
                                hintText: 'At least 8 characters',
                                hintStyle: TextStyle(color: hintTextFieldColor),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: textHeadlineColor.withValues(
                                      alpha: 0.2,
                                    ),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: textHeadlineColor.withValues(
                                      alpha: 0.2,
                                    ),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: textHeadlineColor.withValues(
                                      alpha: 0.2,
                                    ),
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: errorTextColor.withValues(
                                      alpha: 0.2,
                                    ),
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: textHeadlineColor.withValues(
                                      alpha: 0.2,
                                    ),
                                  ),
                                ),
                                contentPadding: EdgeInsets.all(
                                  AppDimensions.paddingSm.width(context),
                                ),
                                suffixIcon: BlocBuilder<AuthBloc, AuthState>(
                                  buildWhen: (previous, current) =>
                                      previous.isPasswordVisible !=
                                      current.isPasswordVisible,
                                  builder: (context, state) {
                                    return InkWell(
                                      onTap: () {
                                        context.read<AuthBloc>().add(
                                          TogglePasswordVisibilityEvent(),
                                        );
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(
                                          (AppDimensions.paddingSm + 4).width(
                                            context,
                                          ),
                                        ),
                                        child: SvgImage(
                                          path: state.isPasswordVisible
                                              ? eyeOnImg
                                              : eyeOffImg,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password is required';
                                } else if (!passwordReg.hasMatch(value)) {
                                  return 'Invalid password';
                                }
                                return null;
                              },
                            );
                          },
                        ),

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
