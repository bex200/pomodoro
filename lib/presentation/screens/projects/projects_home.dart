import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pomodoro/core/themes/app_theme.dart';
import 'package:pomodoro/logic/blocs/auth/auth_bloc.dart';
import 'package:pomodoro/logic/blocs/auth/auth_event.dart';
import 'package:pomodoro/logic/blocs/auth/auth_state.dart';

class ProjectsHomeScreen extends StatelessWidget {
  const ProjectsHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.projectsTitle,
                      style: TextTheme.of(context).titleLarge,
                    ),
                    CircleAvatar(
                      radius: 20,
                      child: Image.asset('assets/images/pomo-t-logo.png',
                          fit: BoxFit.fill),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return ElevatedButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(SignOutEvent());
                      }, child: Text('Temp LOGOUT'));
                },
              ),
              Form(
                child: TextFormField(
                  decoration: InputDecoration(
                          hintText:
                              AppLocalizations.of(context)!.searchProjectHint,
                          prefixIcon: const Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Icon(
                              FontAwesomeIcons.magnifyingGlass,
                              size: 20,
                            ),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 17),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide.none))
                      .copyWith(),
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Expanded(
                child: Scrollbar(
                  thickness: 0.7,
                  child: CustomScrollView(
                    slivers: [
                      SliverList(
                          delegate:
                              SliverChildBuilderDelegate((context, index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Card(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 120,
                                    child: Image.asset(
                                      'assets/images/card-bg.png',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'B2B Plaform',
                                              style: TextTheme.of(context)
                                                  .labelMedium,
                                            ),
                                            Text(
                                              '4 tasks',
                                              style: TextTheme.of(context)
                                                  .bodySmall!
                                                  .copyWith(
                                                      color:
                                                          AppColors.primary400),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          'Apr 28, 2025',
                                          style: TextTheme.of(context)
                                              .bodySmall!
                                              .copyWith(
                                                  color: Theme.of(context)
                                                              .brightness ==
                                                          Brightness.light
                                                      ? AppColors.n600
                                                      : AppColors.n300),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 12),
                                          child: Text(
                                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam sed pharetra nisi. Vivamus',
                                            style: TextTheme.of(context)
                                                .bodySmall!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                                .brightness ==
                                                            Brightness.light
                                                        ? AppColors.n600
                                                        : AppColors.n300),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }, childCount: 4))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
