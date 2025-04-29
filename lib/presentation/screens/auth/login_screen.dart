import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pomodoro/core/themes/app_theme.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isChecked = false;
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
                                  ? AppColors.pastelPurpleLight
                                  : AppColors.pastelPurpleDark,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.welcomeBack,
                            style: TextTheme.of(context).headlineMedium,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            AppLocalizations.of(context)!.enterLogin,
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
                                  style: TextTheme.of(context).labelMedium,
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
                                  style: TextTheme.of(context).labelMedium,
                                  onTapOutside: (event) =>
                                      FocusScope.of(context).unfocus(),
                                  decoration: InputDecoration(
                                      suffixIcon: const Icon(
                                        Icons.remove_red_eye_outlined,
                                        size: 20,
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Checkbox(
                                          materialTapTargetSize:
                                              MaterialTapTargetSize
                                                  .shrinkWrap,
                                          splashRadius: 0,
                                          value: isChecked,
                                          side: BorderSide(
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? AppColors.n600
                                                  : AppColors.n400,
                                              width: 1.25),
                                          onChanged: (value) => {},
                                        ),
                                        TapRegion(
                                          onTapInside: (event) =>
                                              {print('Tapped Remember ME!')},
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .rememberMe,
                                            style: TextTheme.of(context)
                                                .bodySmall!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                                .brightness ==
                                                            Brightness.light
                                                        ? AppColors.black
                                                        : AppColors.white),
                                          ),
                                        )
                                      ],
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        elevation: 0,
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                      onPressed: () => {
                                        // debugPrint(TextTheme.of(context)
                                        //     .bodySmall!
                                        //     .toString())
                                        context.go('/forgotPasswordEmail')
                                      },
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .forgotPassword,
                                        style: TextTheme.of(context)
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
                                SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton(
                                    onPressed: () {},
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
                                const SizedBox(
                                  height: 16,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton(
                                    onPressed: () {},
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                                onPressed: () => context.go('/home'),
                                child: Text(
                                  AppLocalizations.of(context)!.signinButton,
                                )),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.dontHaveAccount,
                                style: TextTheme.of(context)
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
                                  context.go('/register');
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  elevation: 0,
                                  splashFactory: InkSparkle.splashFactory,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!.signupButton,
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
