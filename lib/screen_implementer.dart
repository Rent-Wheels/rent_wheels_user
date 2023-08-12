import 'package:flutter/material.dart';

import 'package:rent_wheels/src/onboarding/widgets/onboarding_slide_widget.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels/core/widgets/carousel/carousel_dots_widget.dart';

class OnboardingScreenMock extends StatefulWidget {
  const OnboardingScreenMock({super.key});

  @override
  State<OnboardingScreenMock> createState() => _OnboardingScreenMockState();
}

class _OnboardingScreenMockState extends State<OnboardingScreenMock> {
  int currentIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    List<Widget> slides = [
      buildOnboadingSlide(
        heading: 'Endless Options',
        imagePath: 'assets/images/new_user_promo_banner.jpeg',
        description: 'Descriptions, descriptions, descriptions',
        context: context,
      ),
      buildOnboadingSlide(
        heading: 'Endless Options',
        imagePath: 'assets/images/new_user_promo_banner.jpeg',
        description: 'Descriptions, descriptions, descriptions',
        context: context,
      ),
    ];
    return Scaffold(
      backgroundColor: rentWheelsNeutralLight0,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes().width(context, 0.04),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: PageView.builder(
                controller: _pageController,
                itemCount: slides.length,
                scrollDirection: Axis.horizontal,
                onPageChanged: (value) => setState(() {
                  currentIndex = value;
                }),
                itemBuilder: (context, index) {
                  return slides[index];
                },
              ),
            ),
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: List.generate(
                      slides.length,
                      (index) => buildCarouselDots(
                        index: index,
                        context: context,
                        width: Sizes().width(context, 0.075),
                        currentIndex: currentIndex,
                        inactiveColor: rentWheelsBrandDark900Trans,
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (currentIndex != slides.length - 1)
                        GestureDetector(
                          onTap: null,
                          child: const Text(
                            'Skip',
                            style: body1Neutral500,
                          ),
                        ),
                      Space().width(context, 0.04),
                      buildGenericButtonWidget(
                        isActive: true,
                        context: context,
                        buttonName: currentIndex == slides.length - 1
                            ? 'Continue'
                            : 'Next',
                        width: Sizes().width(context, 0.25),
                        onPressed: () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.linear,
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
