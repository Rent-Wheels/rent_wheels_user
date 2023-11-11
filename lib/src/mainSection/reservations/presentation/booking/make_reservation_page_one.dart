import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:rent_wheels/core/enums/enums.dart';
import 'package:rent_wheels/core/models/renter/renter_model.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'package:rent_wheels/src/mainSection/reservations/presentation/booking/make_reservation_page_two.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/util/date_formatter.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/models/cars/cars_model.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/global/globals.dart' as global;
import 'package:rent_wheels/core/widgets/popups/error_popup.dart';
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels/core/widgets/search/custom_search_bar.dart';
import 'package:rent_wheels/core/backend/users/methods/user_methods.dart';
import 'package:rent_wheels/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels/core/widgets/textfields/tappable_textfield.dart';
import 'package:rent_wheels/core/models/reservations/reservations_model.dart';
import 'package:rent_wheels/core/widgets/popups/date_range_picker_widget.dart';
import 'package:rent_wheels/core/widgets/loadingIndicator/loading_indicator.dart';
import 'package:rent_wheels/core/widgets/buttons/adaptive_back_button_widget.dart';

class MakeReservationPageOne extends StatefulWidget {
  final Car? car;
  const MakeReservationPageOne({super.key, required this.car});

  @override
  State<MakeReservationPageOne> createState() => _MakeReservationPageOneState();
}

class _MakeReservationPageOneState extends State<MakeReservationPageOne> {
  late num price;

  bool isDateValid = false;
  bool isLocationValid = false;

  Duration duration = const Duration(days: 2);
  TextEditingController location = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;

  TextEditingController date = TextEditingController();

  bool isActive() {
    return isDateValid && isLocationValid;
  }

  Duration getDuration() {
    Car? car = widget.car;
    num days = 0;
    if (car == null) return const Duration(days: 0);
    switch (car.durationUnit) {
      case 'weeks':
        days = car.maxDuration! * 7;
        break;
      case 'days':
        days = car.maxDuration!;
      case 'months':
        int year = DateTime.now().year;
        int month = DateTime.now().month;
        DateTime thisMonth = DateTime(year, month.toInt(), 0);
        DateTime finalMonth =
            DateTime(year, month + car.maxDuration!.toInt(), 0);

        days = finalMonth.difference(thisMonth).inDays;

      default:
        days = 0;
    }

    return Duration(days: days.toInt() - 1);
  }

  showDateRangeSelector() {
    timeDilation = 1;
    return buildDateRangePicker(
      selectedRange: PickerDateRange(startDate, endDate),
      context: context,
      duration: getDuration(),
      onCancel: () => Navigator.pop(context),
      onSubmit: (dateRange) {
        if (dateRange is PickerDateRange) {
          Navigator.pop(context);
          setState(() {
            isDateValid = true;
            endDate = dateRange.endDate;
            startDate = dateRange.startDate;
            setCarPrice();
            date.text =
                '${formatDate(dateRange.startDate!)} - ${formatDate(dateRange.endDate!)}';
          });
        }
      },
    );
  }

  num setCarPrice() {
    Car? car = widget.car;
    if (car == null) return 0;

    Duration duration = endDate?.difference(startDate ?? DateTime.now()) ??
        const Duration(days: 0);

    if (endDate!.isAtSameMomentAs(startDate!)) {
      duration = const Duration(days: 1);
    }

    switch (car.plan) {
      case '/hr':
        price = car.rate! * duration.inHours;
        break;
      case '/day':
        price = car.rate! * duration.inDays;
        break;
      default:
        price = car.rate!;
    }
    return price;
  }

  @override
  void initState() {
    price = widget.car?.rate! ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Car? car = widget.car;

    return Scaffold(
      backgroundColor: rentWheelsNeutralLight0,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: rentWheelsBrandDark900,
        backgroundColor: rentWheelsNeutralLight0,
        leading: buildAdaptiveBackButton(
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes().height(context, 0.02)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Make Reservation",
                style: heading3Information,
              ),
              Space().height(context, 0.01),
              RichText(
                text: TextSpan(
                  text:
                      "You can rent this ${car?.make ?? ''} ${car?.model ?? ''} for a maximum of ",
                  style: body2Brand,
                  children: [
                    TextSpan(
                      text:
                          ' ${car?.maxDuration ?? ''} ${car?.durationUnit ?? ''}',
                      style: heading6BrandBold,
                    ),
                  ],
                ),
              ),
              Space().height(context, 0.03),
              buildTappableTextField(
                  hint: 'Destination',
                  context: context,
                  controller: location,
                  onTap: () async {
                    final response = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CustomSearchScaffold(),
                      ),
                    );

                    if (response != null) {
                      setState(() {
                        location.text = response;
                        isLocationValid = true;
                      });
                    }
                  }),
              Space().height(context, 0.03),
              buildTappableTextField(
                hint: 'Date',
                context: context,
                controller: date,
                onTap: showDateRangeSelector,
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        color: rentWheelsNeutralLight0,
        padding: EdgeInsets.all(Sizes().height(context, 0.02)),
        height: Sizes().height(context, 0.2),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Sizes().width(context, 0.04),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Price',
                    style: heading4Information,
                  ),
                  Text(
                    "GH¢ $price",
                    style: heading4Information,
                  )
                ],
              ),
              Space().height(context, 0.04),
              buildGenericButtonWidget(
                width: Sizes().width(context, 0.85),
                isActive: isActive(),
                buttonName: 'Continue',
                context: context,
                onPressed: () async {
                  try {
                    final reservation = ReservationModel(
                      customer: Customer(
                        id: global.userDetails!.id,
                        name: global.userDetails!.name,
                      ),
                      renter: Renter(id: car!.owner!),
                      car: car,
                      startDate: startDate,
                      returnDate: endDate,
                      destination: location.text,
                      price: price,
                    );
                    buildLoadingIndicator(context, '');
                    final renter = await RentWheelsUserMethods()
                        .getRenterDetails(userId: car.owner!);
                    if (!mounted) return;
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => MakeReservationPageTwo(
                          car: car,
                          renter: renter,
                          reservation: reservation,
                          view: ReservationView.make,
                        ),
                      ),
                    );
                  } catch (e) {
                    if (!mounted) return;
                    Navigator.pop(context);
                    showErrorPopUp(e.toString(), context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
