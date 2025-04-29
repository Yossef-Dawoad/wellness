import 'package:flutter/material.dart';
import 'package:wellness/features/onboarding/presentaions/widgets/visual_indicator.dart';

import '../../../../core/ui/theme.dart';
import '../../../user_questionnaire/presentation/gender_type_selector_screen.dart';
import '../../datasources/onboarding_content_model.dart';
import 'onboarding_page.dart';

class OnboardingViewBody extends StatefulWidget {
  const OnboardingViewBody({super.key});

  @override
  State<OnboardingViewBody> createState() => _OnboardingViewBodyState();
}

class _OnboardingViewBodyState extends State<OnboardingViewBody> {
  late final PageController _pageController;
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height * .8,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: _updatePageIndicator,
            itemCount: onBoardingContentsList.length,
            itemBuilder:
                (ctx, i) => OnBoardingPage(
                  pageContent: onBoardingContentsList[i],
                  pageIndex: _currentPageIndex,
                ),
          ),
        ),
        VisualIndicator(
          controller: _pageController,
          count: onBoardingContentsList.length,
          dotHeight: 14,
        ),
        const SizedBox(height: 16),
        AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: _isLastPage ? 1 : 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Spacing.lg),
            child: ElevatedButton(
              // Handle next navigation
              onPressed: () async {
                // await sl<SharedPrefHelper>().setData(PrefsKeys.isOnBoardingSeen, true);
                // if (context.mounted) {
                //   context.pushReplacement(LoginView.routePath);
                // }
                //TODO: integrate go router
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const GenderTypeSelectorScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
              ),
              child: Text('Next', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
        // const SizedBox(height: 40),
      ],
    );
  }

  bool get _isLastPage => _currentPageIndex == onBoardingContentsList.length - 1;

  void _updatePageIndicator(int index) {
    setState(() => _currentPageIndex = index);
  }

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
