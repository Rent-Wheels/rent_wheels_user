import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

import 'package:rent_wheels/src/mainSection/home/presentation/home.dart';
import 'package:rent_wheels/src/mainSection/profile/presentation/profile.dart';
import 'package:rent_wheels/src/mainSection/reservations/presentation/reservation.dart';

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
      backgroundColor: rentWheelsNeutralLight0,
      appBar: AppBar(
        backgroundColor: rentWheelsNeutralLight0,
        elevation: 0,
      ),
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
              currentIndex == 0
                  ? 'assets/svgs/active_home.svg'
                  : 'assets/svgs/inactive_home.svg',
              colorFilter: const ColorFilter.mode(
                rentWheelsBrandDark800,
                BlendMode.srcIn,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: 'All Cars',
            icon: SvgPicture.asset(
              currentIndex == 1
                  ? 'assets/svgs/active_car.svg'
                  : 'assets/svgs/inactive_car.svg',
              colorFilter: const ColorFilter.mode(
                rentWheelsBrandDark900,
                BlendMode.srcIn,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Reservations',
            icon: SvgPicture.asset(
              currentIndex == 2
                  ? 'assets/svgs/active_reservation.svg'
                  : 'assets/svgs/inactive_reservation.svg',
              colorFilter: const ColorFilter.mode(
                rentWheelsBrandDark900,
                BlendMode.srcIn,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: SvgPicture.asset(
              currentIndex == 3
                  ? 'assets/svgs/active_profile.svg'
                  : 'assets/svgs/inactive_profile.svg',
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
