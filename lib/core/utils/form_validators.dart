// lib/validators.dart
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FormValidators {
  static String? emailValidator(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.emailRequired;
    }
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return AppLocalizations.of(context)!.emailInvalid;
    }
    return null;
  }

  static String? passwordValidator(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.passwordRequired;
    }
    if (value.length < 6) {
      return AppLocalizations.of(context)!.passwordMinLength;
    }
    if (value.length > 20) {
      return AppLocalizations.of(context)!.passwordMaxLength;
    }
    if (!RegExp(r'^(?=.*[a-zA-Z])').hasMatch(value)) {
      return AppLocalizations.of(context)!.passwordAtLeastOneLetter;
    }
    if (!RegExp(r'^(?=.*\d)').hasMatch(value)) {
      return AppLocalizations.of(context)!.passwordAtLeastOneDigit;
    }
    if (!RegExp(r'^(?=.*[!@#$%^&*(),.?":{}|<>])').hasMatch(value)) {
      return AppLocalizations.of(context)!.passwordAtLeastOneSymbol;
    }
    return null;
  }
}
