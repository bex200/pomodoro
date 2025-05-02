import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pomodoro/core/themes/app_theme.dart';
import 'package:pomodoro/core/utils/form_validators.dart';
import 'package:pomodoro/logic/blocs/auth/auth_bloc.dart';
import 'package:pomodoro/logic/blocs/auth/auth_event.dart';
import 'package:pomodoro/logic/blocs/auth/auth_state.dart';
import 'package:pomodoro/presentation/screens/auth/components/auth_form_button_group.dart';
import 'package:pomodoro/presentation/screens/auth/components/auth_header_container.dart';
import 'package:pomodoro/presentation/screens/auth/components/input_field_widget.dart';
import 'package:pomodoro/presentation/screens/auth/components/password_eye_suffix.dart';
import 'package:pomodoro/presentation/screens/auth/components/text_button_widget.dart';
import 'package:pomodoro/presentation/widgets/common/gradient_loading_indicator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isChecked = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isObscure = true;
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ));
          }
        },
        builder: (context, state) {
          return LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AuthHeaderContainerWidget(containerColors: const {
                    'lightBgColor': AppColors.pastelPurpleLight,
                    'darkBgColor': AppColors.pastelPurpleDark
                  }, containerTexts: {
                    'title': AppLocalizations.of(context)!.welcomeBack,
                    'description': AppLocalizations.of(context)!.enterLogin,
                  }),

                  // Form section
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Form(
                        key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.email,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              const SizedBox(height: 6),
                              InputFieldWidget(
                                fieldController: emailController,
                                validator: (value) {
                                  return FormValidators.emailValidator(
                                      value, context);
                                },
                                hintText: AppLocalizations.of(context)!.email,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              const SizedBox(height: 28),
                              Text(
                                AppLocalizations.of(context)!.password,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              const SizedBox(height: 6),
                              InputFieldWidget(
                                isObscure: _isObscure,
                                suffixIcon: fieldInputDecoration(
                                  _isObscure,
                                  () => setState(() {
                                    _isObscure = !_isObscure;
                                  }),
                                ),
                                fieldController: passwordController,
                                validator: (value) {
                                  return FormValidators.passwordValidator(
                                      value, context);
                                },
                                hintText:
                                    AppLocalizations.of(context)!.password,
                              ),
                              const SizedBox(height: 4),
                              // Remember Me and Forgot Password
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButtonWidget(
                                    onPressed: () {
                                      context.push('/forgotPasswordEmail');
                                    },
                                    buttonText: AppLocalizations.of(context)!
                                        .forgotPassword,
                                    buttonTextStyle: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? AppColors.primary400
                                              : AppColors.primary300,
                                        )),
                              ),

                              const SizedBox(height: 12),
                              const Divider(),
                              const SizedBox(height: 12),

                              // Social Sign-in options
                              AuthFormOutlineButton(
                                onPressed: () {
                                  context
                                      .read<AuthBloc>()
                                      .add(SignInWithAppleEvent());
                                },
                                buttonIcon: FontAwesomeIcons.apple,
                                iconColors: const {
                                  'light': AppColors.n900,
                                  'dark': AppColors.white,
                                },
                                buttonText:
                                    AppLocalizations.of(context)!.appleID,
                              ),
                              const SizedBox(height: 16),
                              AuthFormOutlineButton(
                                  onPressed: () {
                                    context
                                        .read<AuthBloc>()
                                        .add(SignInWithGoogleEvent());
                                  },
                                  buttonIcon: FontAwesomeIcons.google,
                                  iconColors: const {
                                    'light': AppColors.primary400,
                                    'dark': AppColors.primary300,
                                  },
                                  buttonText:
                                      AppLocalizations.of(context)!.googleAcc),
                            ]),
                      )),

                  // Bottom section with login button and register option
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: state is AuthLoading
                                  ? null // Disable button during loading
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        context.read<AuthBloc>().add(
                                            SignInWithEmailEvent(
                                                email:
                                                    emailController.text.trim(),
                                                password: passwordController
                                                    .text
                                                    .trim()));
                                      }
                                    },
                              child: state is AuthLoading
                                  ? GradientCircularLoader(
                                      size: 30,
                                      leadingColor: AppColors.primary400,
                                      trailingColor: AppColors.white,
                                      strokeWidth: 4)
                                  : Text(
                                      AppLocalizations.of(context)!
                                          .signinButton,
                                    )),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.dontHaveAccount,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? AppColors.n900
                                        : AppColors.white,
                                  ),
                            ),
                            TextButtonWidget(
                              onPressed: () {
                                context.push('/register');
                              },
                              buttonText:
                                  AppLocalizations.of(context)!.signupButton,
                              buttonTextStyle: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? AppColors.primary400
                                        : AppColors.primary300,
                                  ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}
