import 'package:flutter/material.dart';

import '../../../core/gen/assets.gen.dart';

class OnBoardingContent {
  final Widget title;
  final Widget? subTitle;
  final String image;
  final String? backgroundImage;

  const OnBoardingContent({
    required this.title,
    required this.image,
    this.subTitle,
    this.backgroundImage,
  });
}

List<OnBoardingContent> onBoardingContentsList = [
  OnBoardingContent(
    image: Assets.images.onboarding.workoutSvg.path,
    title: const Text.rich(
      TextSpan(
        text: 'Welcome to ',
        children: [TextSpan(text: 'Wellness App', style: TextStyle(color: Colors.orange))],
      ),
    ),
    subTitle: const Text(
      'Your ultimate companion for a healthier lifestyle. Track workouts and nutrition while achieving your fitness goals.',
      textAlign: TextAlign.center,
    ),
  ),

  OnBoardingContent(
    image: Assets.images.onboarding.mealsSvg.path,
    title: const Text.rich(
      TextSpan(
        text: 'Track Your ',
        children: [TextSpan(text: 'Meals', style: TextStyle(color: Colors.orange))],
      ),
    ),
    subTitle: const Text(
      'Log and track your daily meals to stay on top of your nutrition. Our app makes it easy to record meals and monitor your progress.',
      textAlign: TextAlign.center,
    ),
  ),
];
