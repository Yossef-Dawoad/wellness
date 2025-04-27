import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../datasources/onboarding_content_model.dart';
import 'package:vector_graphics/vector_graphics.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key, required this.pageContent, required this.pageIndex});

  final OnBoardingContent pageContent;
  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height * .5,
          width: MediaQuery.sizeOf(context).width,
          child: Stack(
            children: [
              if (pageContent.backgroundImage != null)
                Positioned.fill(
                  child: SvgPicture(
                    AssetBytesLoader(pageContent.backgroundImage!),
                    fit: BoxFit.fill,
                  ),
                ),

              VectorGraphic(loader: AssetBytesLoader(pageContent.image), fit: BoxFit.contain),
              Align(
                alignment: Alignment.topRight,
                child: Visibility(
                  visible: pageIndex == 0,
                  child: GestureDetector(
                    // onTap: () => context.pushReplacementNamed(LoginView.routePath),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('Skip', style: Theme.of(context).textTheme.bodyMedium),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 54),
        DefaultTextStyle(
          style: Theme.of(context).textTheme.headlineSmall!,
          child: pageContent.title,
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: DefaultTextStyle(
            style: Theme.of(context).textTheme.bodySmall!,
            child: pageContent.subTitle ?? const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }
}
