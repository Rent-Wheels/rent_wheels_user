import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:rent_wheels/src/authentication/signup/presentation/signup.dart';
import 'package:rent_wheels/src/onboarding/widgets/onboarding_slide_widget.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels/core/widgets/carousel/carousel_dots_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    List<Widget> slides = [
      buildOnboadingSlide(
        context: context,
        heading: 'Your Journey Begins Here',
        imagePath: 'assets/images/onboarding_1.JPG',
        description:
            "Get ready to experience hassle-free car rentals with Rent Wheels. We're here to make your travel dreams a reality.",
      ),
      buildOnboadingSlide(
        context: context,
        heading: 'Find Your Perfect Match',
        imagePath: 'assets/images/onboarding_3.JPG',
        description:
            "Explore a fleet of cars tailored to your preferences. From compact to luxury, we have the ride that suits your style.",
      ),
      buildOnboadingSlide(
        context: context,
        heading: 'Hit the Road in Minutes',
        imagePath: 'assets/images/onboarding_2.JPG',
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
                          onTap: () async {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setBool('firstTime', false);

                            if (!mounted) return;
                            Navigator.pushReplacement(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const SignUp(
                                  onboarding: true,
                                ),
                              ),
                            );
                          },
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
                            ? 'Sign Up'
                            : 'Next',
                        width: Sizes().width(context, 0.25),
                        onPressed: () async {
                          if (currentIndex == slides.length - 1) {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setBool('firstTime', false);

                            if (!mounted) return;
                            Navigator.pushReplacement(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const SignUp(
                                  onboarding: true,
                                ),
                              ),
                            );
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
