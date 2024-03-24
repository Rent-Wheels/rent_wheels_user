// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// import 'package:rent_wheels/src/mainSection/cars/presentation/car_details.dart';

// import 'package:rent_wheels/core/enums/enums.dart';
// import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
// import 'package:rent_wheels/core/models/cars/cars_model.dart';
// import 'package:rent_wheels/core/widgets/popups/error_popup.dart';
// import 'package:rent_wheels/src/cars/presentation/widgets/cars_info_sections.dart';
// import 'package:rent_wheels/core/backend/car/methods/cars_methods.dart';
// import 'package:rent_wheels/core/widgets/error/error_message_widget.dart';
// import 'package:rent_wheels/core/backend/users/methods/user_methods.dart';
// import 'package:rent_wheels/core/widgets/loadingIndicator/loading_indicator.dart';
// import 'package:rent_wheels/core/widgets/loadingIndicator/shimmer_loading_placeholder.dart';

// class AvailableCarsData extends StatefulWidget {
//   final AvailableCarsType type;
//   const AvailableCarsData({super.key, required this.type});

//   @override
//   State<AvailableCarsData> createState() => _AvailableCarsDataState();
// }

// class _AvailableCarsDataState extends State<AvailableCarsData> {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: RentWheelsCarsMethods().getAllAvailableCars(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return widget.type == AvailableCarsType.preview
//               ? ListView.builder(
//                   shrinkWrap: true,
//                   itemCount:
//                       snapshot.data!.length > 4 ? 5 : snapshot.data!.length,
//                   scrollDirection: Axis.horizontal,
//                   itemBuilder: (context, index) {
//                     return CarsInfoSections(
//                       isLoading: false,
//                       carDetails: snapshot.data![index],
//                       width: Sizes().width(context, 0.6),
//                       margin: Sizes().width(context, 0.03),
//                       onTap: () async {
//                         buildLoadingIndicator(context, '');
//                         try {
//                           final renter = await RentWheelsUserMethods()
//                               .getRenterDetails(
//                                   userId: snapshot.data![index].owner!);

//                           if (!mounted) return;
//                           context.pop();
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => CarDetails(
//                                 car: snapshot.data![index],
//                                 renter: renter,
//                               ),
//                             ),
//                           );
//                         } catch (e) {
//                           if (!mounted) return;
//                           context.pop();
//                           showErrorPopUp(e.toString(), context);
//                         }
//                       },
//                     );
//                   })
//               : GridView.builder(
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     mainAxisExtent: Sizes().height(context, 0.3),
//                     crossAxisSpacing: Sizes().width(context, 0.02),
//                   ),
//                   itemCount: snapshot.data!.length,
//                   shrinkWrap: true,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: EdgeInsets.symmetric(
//                         vertical: Sizes().height(context, 0.02),
//                       ),
//                       child: CarsInfoSections(
//                         height: Sizes().height(context, 0.15),
//                         carDetails: snapshot.data![index],
//                         isLoading: false,
//                         width: Sizes().width(context, 0.5),
//                         onTap: () async {
//                           buildLoadingIndicator(context, '');
//                           try {
//                             final renter = await RentWheelsUserMethods()
//                                 .getRenterDetails(
//                                     userId: snapshot.data![index].owner!);

//                             if (!mounted) return;
//                             context.pop();
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => CarDetails(
//                                   car: snapshot.data![index],
//                                   renter: renter,
//                                 ),
//                               ),
//                             );
//                           } catch (e) {
//                             if (!mounted) return;
//                             context.pop();
//                             showErrorPopUp(e.toString(), context);
//                           }
//                         },
//                       ),
//                     );
//                   },
//                 );
//         }
//         if (snapshot.hasError) {
//           return const ErrorMessage(
//             label: 'An error occured',
//             errorMessage: 'Please check your internet connection.',
//           );
//         }
//         return widget.type == AvailableCarsType.preview
//             ? ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: 2,
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (context, _) {
//                   return ShimmerLoading(
//                     isLoading: true,
//                     child: CarsInfoSections(
//                       margin: Sizes().width(context, 0.03),
//                       isLoading: true,
//                       carDetails: Car(media: [Media(mediaURL: '')]),
//                       width: Sizes().width(context, 0.6),
//                       onTap: null,
//                     ),
//                   );
//                 },
//               )
//             : GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   mainAxisExtent: Sizes().height(context, 0.28),
//                   crossAxisSpacing: Sizes().width(context, 0.02),
//                 ),
//                 itemCount: 8,
//                 shrinkWrap: true,
//                 itemBuilder: (context, _) {
//                   return Padding(
//                     padding: EdgeInsets.symmetric(
//                       vertical: Sizes().height(context, 0.02),
//                     ),
//                     child: ShimmerLoading(
//                       isLoading: true,
//                       child: CarsInfoSections(
//                         height: Sizes().height(context, 0.15),
//                         carDetails: Car(media: [Media(mediaURL: '')]),
//                         isLoading: true,
//                         width: Sizes().width(context, 0.5),
//                         onTap: null,
//                       ),
//                     ),
//                   );
//                 },
//               );
//       },
//     );
//   }
// }
