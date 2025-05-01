import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pomodoro/core/themes/app_theme.dart';
import 'package:pomodoro/logic/blocs/auth/auth_bloc.dart';
import 'package:pomodoro/logic/blocs/auth/auth_event.dart';
import 'package:pomodoro/logic/blocs/auth/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isChecked = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isObscure = true; // For password visibility toggle
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    // Clean up controllers when the widget is disposed
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
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ));
          }
        },
        builder: (context, state) {
          return LayoutBuilder(
            builder: (context, constraints) {
              return ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                    maxHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Your existing header UI...
                        Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.20,
                          alignment: AlignmentDirectional.bottomStart,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 24),
                          decoration: BoxDecoration(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? AppColors.pastelPurpleLight
                                  : AppColors.pastelPurpleDark,
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(25),
                                  bottomRight: Radius.circular(25))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.welcomeBack,
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                AppLocalizations.of(context)!.enterLogin,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: Theme.of(context).brightness ==
                                                Brightness.light
                                            ? AppColors.n800
                                            : AppColors.n200),
                              ),
                            ],
                          ),
                        ),

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
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                    const SizedBox(height: 6),
                                    TextFormField(
                                      controller: emailController,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                      onTapOutside: (event) =>
                                          FocusScope.of(context).unfocus(),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your email';
                                        }
                                        if (!RegExp(
                                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                            .hasMatch(value)) {
                                          return 'Please enter a valid email';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .email,
                                          enabledBorder:
                                              const OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(16)),
                                                  borderSide: BorderSide.none)),
                                    ),
                                    const SizedBox(height: 28),
                                    Text(
                                      AppLocalizations.of(context)!.password,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                    const SizedBox(height: 6),
                                    TextFormField(
                                      controller: passwordController,
                                      obscureText: _isObscure,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                      onTapOutside: (event) =>
                                          FocusScope.of(context).unfocus(),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your password';
                                        }
                                        if (value.length < 6) {
                                          return 'Password must be at least 6 characters';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _isObscure
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              size: 20,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _isObscure = !_isObscure;
                                              });
                                            },
                                          ),
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .password,
                                          enabledBorder:
                                              const OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(16)),
                                                  borderSide: BorderSide.none)),
                                    ),
                                    const SizedBox(height: 4),
                                    // Remember Me and Forgot Password
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            elevation: 0,
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
                                          ),
                                          onPressed: () {
                                            context
                                                .push('/forgotPasswordEmail');
                                          },
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .forgotPassword,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                  color: Theme.of(context)
                                                              .brightness ==
                                                          Brightness.light
                                                      ? AppColors.primary400
                                                      : AppColors.primary300,
                                                ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.01),
                                    const Divider(),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.01),

                                    // Social Sign-in options
                                    SizedBox(
                                      width: double.infinity,
                                      child: OutlinedButton(
                                        onPressed: () {
                                          // Handle Apple sign-in
                                          context
                                              .read<AuthBloc>()
                                              .add(SignInWithAppleEvent());
                                        },
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Icon(
                                                FontAwesomeIcons.apple,
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? AppColors.n900
                                                    : AppColors.white,
                                                size: 24,
                                              ),
                                            ),
                                            Center(
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .appleID,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    SizedBox(
                                      width: double.infinity,
                                      child: OutlinedButton(
                                        onPressed: () {
                                          print('google');
                                          context
                                              .read<AuthBloc>()
                                              .add(SignInWithGoogleEvent());
                                        },
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            const Align(
                                              alignment: Alignment.centerLeft,
                                              child: Icon(
                                                FontAwesomeIcons.google,
                                                color: AppColors.primary200,
                                                size: 19,
                                              ),
                                            ),
                                            Center(
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .googleAcc,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ]),
                            )),

                        // Bottom section with login button and register option
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 20),
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
                                            if (_formKey.currentState!
                                                .validate()) {
                                              context.read<AuthBloc>().add(
                                                  SignInWithEmailEvent(
                                                      email: emailController
                                                          .text
                                                          .trim(),
                                                      password:
                                                          passwordController
                                                              .text
                                                              .trim()));
                                            }
                                          },
                                    child: state is AuthLoading
                                        ? const CircularProgressIndicator()
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
                                    AppLocalizations.of(context)!
                                        .dontHaveAccount,
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
                                  TextButton(
                                    onPressed: () {
                                      context.push('/register');
                                    },
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      elevation: 0,
                                      splashFactory: InkSparkle.splashFactory,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .signupButton,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? AppColors.primary400
                                                    : AppColors.primary300,
                                          ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ));
            },
          );
        },
      ),
    );
  }
}
