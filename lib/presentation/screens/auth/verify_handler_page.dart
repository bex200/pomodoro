import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:pomodoro/core/themes/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pomodoro/presentation/widgets/common/gradient_loading_indicator.dart';

class EmailVerificationHandlerPage extends StatefulWidget {
  final String? oobCode;

  const EmailVerificationHandlerPage({Key? key, this.oobCode})
      : super(key: key);

  @override
  State<EmailVerificationHandlerPage> createState() =>
      _EmailVerificationHandlerPageState();
}

class _EmailVerificationHandlerPageState
    extends State<EmailVerificationHandlerPage> {
  @override
  void initState() {
    super.initState();
    _verifyEmail();
  }

  Future<void> _verifyEmail() async {
    final code = widget.oobCode;
    if (code == null) {
      _showError('Missing verification code.');
      return;
    }

    try {
      await FirebaseAuth.instance.checkActionCode(code);
      await FirebaseAuth.instance.applyActionCode(code);

      // Force refresh the user
      await FirebaseAuth.instance.currentUser?.reload();

      // Navigate to /home
      context.go('/home');
    } catch (e) {
      _showError('Invalid or expired verification link.');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
    Future.delayed(
        const Duration(seconds: 2), () => context.go('/verify-email'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin: EdgeInsets.only(bottom: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.loadingTitle,
              style: TextTheme.of(context).titleLarge!.copyWith(
                  color: Theme.of(context).brightness == Brightness.light
                      ? AppColors.n900
                      : AppColors.white),
            ),
            const SizedBox(
              height: 30,
            ),
            GradientCircularLoader(
                strokeWidth: 6.8,
                size: 54,
                leadingColor: Theme.of(context).brightness == Brightness.light
                    ? AppColors.white
                    : AppColors.n900,
                trailingColor: AppColors.primary300),
          ],
        ),
      ),
    );
  }
}
