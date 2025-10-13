import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_colors.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_dimensions.dart';
import 'package:smart_digital_wallet/src/core/common/extensions/sizes_extensions.dart';
import 'package:smart_digital_wallet/src/core/common/helper/loading_dialog.dart';
import 'package:smart_digital_wallet/src/core/common/helper/responsive_helper.dart';
import 'package:smart_digital_wallet/src/core/common/helper/snack_bars.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/app_button.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/text_widget_xl.dart';
import 'package:smart_digital_wallet/src/core/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:smart_digital_wallet/src/core/features/auth/presentation/widgets/signin/email_form_field.dart';
import 'package:smart_digital_wallet/src/core/features/auth/presentation/widgets/signin/password_form_field.dart';
import 'package:smart_digital_wallet/src/core/features/auth/presentation/widgets/signin/security_header.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidgetXl(text: 'Sign In', textColor: textHeadlineColor),
        backgroundColor: primaryColor.withValues(alpha: 0.15),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listenWhen: (previous, current) =>
            previous.isSignInLoading != current.isSignInLoading ||
            previous.errorMessage != current.errorMessage ||
            previous.isLoggedIn != current.isLoggedIn,
        listener: (context, state) {
          if (state.isSignInLoading) {
            showLoadingDialog(context);
          } else {
            if (context.canPop()) {
              context.pop();
            }
          }
          if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                failureSnackBar(title: 'Error!', message: state.errorMessage),
              );
          }
          if (state.isLoggedIn) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                successSnackBar(
                  title: 'Success!',
                  message: 'Logged in successfully',
                ),
              );
          }
        },
        child: SafeArea(
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
                        EmailFormField(emailController: _emailController),
                        SizedBox(
                          height: AppDimensions.spacingMd.height(context),
                        ),
                        PasswordFormField(
                          passwordController: _passwordController,
                        ),
                        const Spacer(),
                        AppButton(
                          text: 'Sign In',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                SignInEvent(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                ),
                              );
                            }
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
