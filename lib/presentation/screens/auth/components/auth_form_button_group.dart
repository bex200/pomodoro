import 'package:flutter/material.dart';

class AuthFormOutlineButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData buttonIcon;
  final Map<String, Color> iconColors;
  final String buttonText;
  const AuthFormOutlineButton(
      {super.key,
      required this.onPressed,
      required this.buttonIcon,
      required this.iconColors,
      required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Icon(
                buttonIcon,
                color: Theme.of(context).brightness == Brightness.light
                    ? iconColors['light']
                    : iconColors['dark'],
                // ? AppColors.n900
                // : AppColors.white,
                size: 24,
              ),
            ),
            Center(
              child: Text(
                  // AppLocalizations.of(context)!.appleID,
                  buttonText),
            ),
          ],
        ),
      ),
    );
  }
}
