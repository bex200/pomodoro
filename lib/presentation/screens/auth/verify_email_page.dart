import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pomodoro/core/themes/app_theme.dart';
import 'package:pomodoro/data/repositories/auth_repository_impl.dart';
import 'package:pomodoro/presentation/screens/auth/components/text_button_widget.dart';
import 'package:pomodoro/presentation/widgets/common/gradient_loading_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VerifyEmailPromptPage extends StatefulWidget {
  const VerifyEmailPromptPage({Key? key}) : super(key: key);

  @override
  State<VerifyEmailPromptPage> createState() => _VerifyEmailPromptPageState();
}

class _VerifyEmailPromptPageState extends State<VerifyEmailPromptPage> {
  bool _resent = false;
  bool _loading = false;

  Future<void> _resendVerificationEmail() async {
    setState(() {
      _loading = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      final _authRepository = AuthRepositoryImpl();
      await _authRepository.sendEmailVerification((user?.email)!);

      setState(() {
        _resent = true;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to resend verification email.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.envelopeOpenText,
              size: 100,
              color: AppColors.primary400,
            ),
            const SizedBox(height: 24),
            Text(
              AppLocalizations.of(context)!.emailVerificationPrompt,
              textAlign: TextAlign.center,
              style: TextTheme.of(context).bodyMedium,
            ),
            const SizedBox(height: 24),
            if (_resent)
              const Text(
                'Verification email resent!',
                style: TextStyle(color: Colors.green),
              ),
            if (_loading)
              GradientCircularLoader(
                  strokeWidth: 6.8,
                  size: 54,
                  leadingColor: Theme.of(context).brightness == Brightness.light
                      ? AppColors.white
                      : AppColors.n900,
                  trailingColor: AppColors.primary300)
            else
              TextButtonWidget(
                onPressed: _resendVerificationEmail,
                buttonText: 'Resend Email',
                buttonTextStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(
                      color: Theme.of(context).brightness == Brightness.light
                          ? AppColors.primary400
                          : AppColors.primary300,
                    ),
              ),
          ],
        ),
      ),
    );
  }
}
