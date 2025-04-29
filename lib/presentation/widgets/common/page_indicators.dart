import 'package:flutter/material.dart';
import 'package:pomodoro/core/themes/app_theme.dart';

class PageIndicators extends StatelessWidget {
  final int currentPage;
  final int count;
  const PageIndicators(
      {super.key, required this.currentPage, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(count, (index) {
          bool isActive = index == currentPage;
          return isActive
              ? Container(
                  width: 32,
                  height: 8,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.light ? AppColors.n900 : AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                )
              : Container(
                  width: 8,
                  margin: const EdgeInsets.only(right: 8),
                  height: 8,
                  decoration:  BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.light ? AppColors.n200 : AppColors.n800,
                    shape: BoxShape.circle,
                  ),
                );
        }));
  }
}
