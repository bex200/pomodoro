import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pomodoro/core/themes/app_theme.dart';
import 'package:pomodoro/logic/blocs/auth/auth_bloc.dart';
import 'package:pomodoro/logic/blocs/auth/auth_event.dart';
import 'package:pomodoro/logic/blocs/auth/auth_state.dart';

class ForgotPasswordEmailScreen extends StatefulWidget {
  const ForgotPasswordEmailScreen({super.key});

  @override
  State<ForgotPasswordEmailScreen> createState() => _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is PasswordResetSentState) {
          context.go('/forgotPasswordOtp');
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 44, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 25,
                ),
                child: GestureDetector(
                  onTap: () => context.pop(),
                  child: Icon(
                    FontAwesomeIcons.arrowLeft,
                    size: 26,
                  ),
                ),
              ),
              Text(
                AppLocalizations.of(context)!.resetTitle,
                style: TextTheme.of(context).headlineMedium,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                AppLocalizations.of(context)!.resetDescription,
                style: TextTheme.of(context).bodyMedium!.copyWith(
                    color: Theme.of(context).brightness == Brightness.light
                        ? AppColors.n600
                        : AppColors.n400),
              ),
              const SizedBox(
                height: 40,
              ),
              Form(
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
                          controller: emailController,
                          style: TextTheme.of(context).labelMedium,
                          onTapOutside: (event) =>
                              FocusScope.of(context).unfocus(),
                          decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!.email,
                              enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                  borderSide: BorderSide.none)),
                        ),
                      ])),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(ForgotPasswordEvent(
                          email: emailController.text.trim()));
                    },
                    child: Text(
                      AppLocalizations.of(context)!.signinButton,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
