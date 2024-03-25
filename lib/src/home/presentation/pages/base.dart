import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:rent_wheels/assets/svgs/svg_constants.dart';

import 'package:rent_wheels/src/home/presentation/pages/home.dart';
import 'package:rent_wheels/src/mainSection/profile/presentation/profile.dart';
import 'package:rent_wheels/src/cars/presentation/pages/available_cars.dart';
import 'package:rent_wheels/src/reservations/presentation/pages/reservation.dart';

import 'package:rent_wheels/core/widgets/theme/colors.dart';

class MainSection extends StatefulWidget {
  final int? pageIndex;
  const MainSection({super.key, this.pageIndex});

  @override
  State<MainSection> createState() => _MainSectionState();
}

class _MainSectionState extends State<MainSection> {
  int currentIndex = 0;

  void changeIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void setCurrentIndex() {
    if (widget.pageIndex != null) {
      setState(() {
        currentIndex = widget.pageIndex!;
      });
    }
  }

  static const List<Widget> _pages = [
    Home(),
    AvailableCars(),
    Reservations(),
    Profile(),
  ];

  @override
  void initState() {
    setCurrentIndex();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        enableFeedback: true,
        elevation: 10,
        backgroundColor: rentWheelsNeutralLight0,
        onTap: changeIndex,
        currentIndex: currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            label: 'Dashboard',
            icon: SvgPicture.asset(
              currentIndex == 0 ? activeHomeSVG : inactiveHomeSVG,
              colorFilter: const ColorFilter.mode(
                rentWheelsBrandDark800,
                BlendMode.srcIn,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Available Cars',
            icon: SvgPicture.asset(
              currentIndex == 1 ? activeCarSVG : inactiveCarSVG,
              colorFilter: const ColorFilter.mode(
                rentWheelsBrandDark900,
                BlendMode.srcIn,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Reservations',
            icon: SvgPicture.asset(
              currentIndex == 2 ? activeReservationSVG : inactiveReservationSVG,
              colorFilter: const ColorFilter.mode(
                rentWheelsBrandDark900,
                BlendMode.srcIn,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: SvgPicture.asset(
              currentIndex == 3 ? activeProfileSVG : inactiveProfileSVG,
              colorFilter: const ColorFilter.mode(
                rentWheelsBrandDark900,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
