import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:pomodoro/core/themes/app_theme.dart';
import 'package:pomodoro/core/utils/form_validators.dart';

class InputFieldWidget extends StatelessWidget {
  final TextEditingController fieldController;
  final String hintText;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final bool? isObscure;
  final TextInputType? keyboardType;
  final VoidCallback? onEyePressed;
  const InputFieldWidget({
    super.key,
    required this.fieldController,
    required this.validator,
    required this.hintText,
    this.isObscure,
    this.onEyePressed,
    this.suffixIcon,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: fieldController,
      style: Theme.of(context).textTheme.labelMedium,
      obscureText: isObscure ?? false,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide.none),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
