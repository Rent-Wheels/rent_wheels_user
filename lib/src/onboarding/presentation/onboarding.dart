import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rent_wheels/assets/images/image_constants.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';

import 'package:rent_wheels/src/global/presentation/provider/global_provider.dart';
import 'package:rent_wheels/src/onboarding/widgets/onboarding_slide_widget.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels/core/widgets/carousel/carousel_dots_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  completeOnboarding() async {
    await context.read<GlobalProvider>().setOnboardingStatus(true);

    if (!mounted) return;

    context.goNamed(
      'signUp',
      queryParameters: {
        'onboarding': 'true',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> slides = [
      buildOnboadingSlide(
        context: context,
        heading: 'Your Journey Begins Here',
        imagePath: onboarding1Img,
        description:
            "Get ready to experience hassle-free car rentals with Rent Wheels. We're here to make your travel dreams a reality.",
      ),
      buildOnboadingSlide(
        context: context,
        heading: 'Find Your Perfect Match',
        imagePath: onboarding3Img,
        description:
            "Explore a fleet of cars tailored to your preferences. From compact to luxury, we have the ride that suits your style.",
      ),
      buildOnboadingSlide(
        context: context,
        heading: 'Hit the Road in Minutes',
        imagePath: onboarding2Img,
        description:
            "With Rent Wheels, renting a car is a breeze. Just a few taps and you're off on your adventure. Your journey, your way.",
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
                      (index) => CarouselDots(
                        index: index,
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
                          onTap: () async => await completeOnboarding(),
                          child: Text(
                            'Skip',
                            style: theme.textTheme.bodyLarge!.copyWith(
                              color: rentWheelsNeutral,
                            ),
                          ),
                        ),
                      Space().width(context, 0.04),
                      GenericButton(
                        isActive: true,
                        buttonName: currentIndex == slides.length - 1
                            ? 'Sign Up'
                            : 'Next',
                        width: Sizes().width(context, 0.25),
                        onPressed: () async {
                          if (currentIndex == slides.length - 1) {
                            completeOnboarding();
                          }
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
