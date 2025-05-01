import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

CustomTransitionPage buildPageWithTransition(Widget child) {
  return CustomTransitionPage(
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Define the beginning and end of the transition
      const begin = Offset(0.0, 0.05); // Subtle vertical slide
      const end = Offset.zero;
      const curve = Curves.easeInOutCubic;

      // Set up the tween animation for both the slide and the fade
      var slideTween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var fadeTween = Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));

      // Combine the slide and fade effects with a staggered animation for a smooth transition
      var slideAnimation = animation.drive(slideTween);
      var fadeAnimation = animation.drive(fadeTween);

      return FadeTransition(
        opacity: fadeAnimation, // Fade effect
        child: SlideTransition(
          position: slideAnimation, // Slide effect
          child: child,
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 500), // Smooth and controlled duration
  );
}
