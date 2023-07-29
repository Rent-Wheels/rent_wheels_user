import 'package:flutter/material.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';

import '../../../../../core/widgets/buttons/adaptive_back_button_widget.dart';
import '../../../../../core/widgets/textStyles/text_styles.dart';
import '../../../../../core/widgets/theme/colors.dart';

class ReservationSuccessfulScreen extends StatelessWidget {
  const ReservationSuccessfulScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Stack(
            children: [
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                buildAdaptiveBackButton(onPressed: ()=> Navigator.of(context).pop()),
                 const Text('Checkout', style: heading2Brand,),
              ],)
          ),
              Align(
                alignment: Alignment.center,
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
               mainAxisSize: MainAxisSize.min,
               children: [
                 Column(children: [
                   const Image(image: AssetImage('assets/images/car_image.webp')),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0 ,20 ,0 ,20),
                    child: Text('Your booking success!', style: heading4Brand,),
                  ),
                   Text('Congratulations you booking has been made.', style: heading5BrandDeselect,),
                   const SizedBox(height: 5),
                   Text('Thanks for trusting us!', style: heading5BrandDeselect),
                 ],
                 )
               ],
              ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: (){},
                  child: Container(
                    height: 60,
                      width:MediaQuery.of(context).size.width - 60 ,
                    decoration:  BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                        color: rentWheelsNeutralDark900,),
                    child: const Center(child: Text('Back to homepage',
                      style: TextStyle(color: rentWheelsNeutralLight100,
                          fontSize:22,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.bold),
                    ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
