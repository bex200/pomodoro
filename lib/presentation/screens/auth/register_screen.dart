import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pomodoro/core/themes/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pomodoro/core/utils/form_validators.dart';
import 'package:pomodoro/logic/blocs/auth/auth_bloc.dart';
import 'package:pomodoro/logic/blocs/auth/auth_event.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    bool _isObscure = true; // For password visibility toggle

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
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
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.20,
                      alignment: AlignmentDirectional.bottomStart,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 24),
                      decoration: BoxDecoration(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? AppColors.pastelYellowBright
                                  : AppColors.pastelYellowDark,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.welcome,
                            style: TextTheme.of(context).headlineMedium,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            AppLocalizations.of(context)!.createAccount,
                            style: TextTheme.of(context).bodyMedium!.copyWith(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? AppColors.n800
                                    : AppColors.n200),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Form(
                          key: _formKey,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.email,
                                  style: TextTheme.of(context).labelMedium,
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: emailController,
                                  style: TextTheme.of(context).labelMedium,
                                  validator: (value) {
                                    return FormValidators.emailValidator(
                                        value, context);
                                  },
                                  onTapOutside: (event) =>
                                      FocusScope.of(context).unfocus(),
                                  decoration: InputDecoration(
                                      hintText:
                                          AppLocalizations.of(context)!.email,
                                      enabledBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16)),
                                          borderSide: BorderSide.none)),
                                ),
                                const SizedBox(
                                  height: 28,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.password,
                                  style: TextTheme.of(context).labelMedium,
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                TextFormField(
                                  obscureText: _isObscure,
                                  controller: passwordController,
                                  style: TextTheme.of(context).labelMedium,
                                  validator: (value) {
                                    return FormValidators.passwordValidator(
                                        value, context);
                                  },
                                  onTapOutside: (event) =>
                                      FocusScope.of(context).unfocus(),
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _isObscure
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          size: 20,
                                        ),
                                        onPressed: () => setState(() {
                                          _isObscure = !_isObscure;
                                        }),
                                      ),
                                      hintText: AppLocalizations.of(context)!
                                          .password,
                                      enabledBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16)),
                                          borderSide: BorderSide.none)),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: TapRegion(
                                    onTapInside: (event) =>
                                        {print('Tapped Agree to terms!')},
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      AppLocalizations.of(context)!
                                          .agreeToTerms,
                                      style: TextTheme.of(context)
                                          .bodySmall!
                                          .copyWith(
                                              decoration:
                                                  TextDecoration.underline,
                                              fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01),
                                const Divider(),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01),
                                SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      //* IMPLEMENT that later when ill need
                                    },
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Icon(
                                            FontAwesomeIcons.apple,
                                            color:
                                                Theme.of(context).brightness ==
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
                                const SizedBox(
                                  height: 16,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton(
                                    onPressed: () {
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
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 20),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    context.read<AuthBloc>().add(
                                        SignUpWithEmailEvent(
                                            email: emailController.text.trim(),
                                            password: passwordController.text
                                                .trim()));
                                  }
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.signupButton,
                                )),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            // mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.haveAnAccount,
                                style:
                                    TextTheme.of(context).labelLarge!.copyWith(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? AppColors.n900
                                              : AppColors.white,
                                        ),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.push('/login');
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  elevation: 0,
                                  splashFactory: InkSparkle.splashFactory,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ).copyWith(
                                  padding:
                                      WidgetStateProperty.all(EdgeInsets.zero),
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!.signinButton,
                                  style: TextTheme.of(context)
                                      .labelLarge!
                                      .copyWith(
                                        color: Theme.of(context).brightness ==
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
      ),
    );
  }
}
