import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'package:rent_wheels/injection.dart';
import 'package:rent_wheels/core/util/date_util.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/widgets/popups/error_popup.dart';
import 'package:rent_wheels/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels/core/widgets/textfields/tappable_textfield.dart';
import 'package:rent_wheels/core/widgets/popups/date_range_picker_widget.dart';
import 'package:rent_wheels/core/widgets/loadingIndicator/loading_indicator.dart';
import 'package:rent_wheels/core/widgets/textfields/generic_textfield_widget.dart';
import 'package:rent_wheels/core/widgets/buttons/adaptive_back_button_widget.dart';

import 'package:rent_wheels/src/cars/domain/entity/cars.dart';
import 'package:rent_wheels/src/cars/data/models/cars_model.dart';
import 'package:rent_wheels/src/reservations/domain/entity/customer.dart';
import 'package:rent_wheels/src/renter/presentation/bloc/renter_bloc.dart';
import 'package:rent_wheels/src/reservations/domain/entity/reservations.dart';
import 'package:rent_wheels/src/global/presentation/provider/global_provider.dart';

class MakeReservationPageOne extends StatefulWidget {
  final String? car;
  const MakeReservationPageOne({super.key, required this.car});

  @override
  State<MakeReservationPageOne> createState() => _MakeReservationPageOneState();
}

class _MakeReservationPageOneState extends State<MakeReservationPageOne> {
  late num price;

  Car? _car;
  DateTime? endDate;
  DateTime? startDate;

  bool isDateValid = false;
  bool isLocationValid = false;
  bool isDateRangeSelected = false;
  TextEditingController date = TextEditingController();
  TextEditingController location = TextEditingController();
  DateRangePickerController dateRangePicker = DateRangePickerController();

  final _renterBloc = sl<RenterBloc>();

  initData() {
    if (widget.car != null) {
      _car = CarModel.fromJSON(jsonDecode(widget.car!));
    }
    price = _car?.rate! ?? 0;
  }

  bool isActive() {
    return isDateValid && isLocationValid;
  }

  Duration getDuration() {
    num days = 0;
    if (_car == null) return const Duration(days: 0);
    switch (_car!.durationUnit) {
      case 'weeks':
        days = _car!.maxDuration! * 7;
        break;
      case 'days':
        days = _car!.maxDuration!;
      case 'months':
        int year = DateTime.now().year;
        int month = DateTime.now().month;
        DateTime thisMonth = DateTime(year, month.toInt(), 0);
        DateTime finalMonth =
            DateTime(year, month + _car!.maxDuration!.toInt(), 0);

        days = finalMonth.difference(thisMonth).inDays;

      default:
        days = 0;
    }

    return Duration(days: days.toInt() - 1);
  }

  showDateRangeSelector() {
    timeDilation = 1;
    return buildDateRangePicker(
      context: context,
      date: dateRangePicker,
      duration: getDuration(),
      onCancel: () => context.pop(),
      isDateRangeSelected: isDateRangeSelected,
      selectedRange: PickerDateRange(startDate, endDate),
      onSubmit: (dateRange) {
        if (dateRange is PickerDateRange) {
          context.pop();
          setState(
            () {
              isDateValid = true;
              endDate = dateRange.endDate;
              startDate = dateRange.startDate;
              setCarPrice();
              date.text =
                  '${formatDate(dateRange.startDate!)} - ${formatDate(dateRange.endDate!)}';
            },
          );
        }
      },
    );
  }

  num setCarPrice() {
    if (_car == null) return 0;

    Duration duration = endDate?.difference(startDate ?? DateTime.now()) ??
        const Duration(days: 0);

    if (endDate!.isAtSameMomentAs(startDate!)) {
      duration = const Duration(days: 1);
    }

    switch (_car!.plan) {
      case '/hr':
        price = _car!.rate! * duration.inHours;
        break;
      case '/day':
        price = _car!.rate! * duration.inDays;
        break;
      default:
        price = _car!.rate!;
    }
    return price;
  }

  submitReservationDetails() {
    buildLoadingIndicator(context, '');
    final params = {
      'urlParameters': {
        'renterId': _car!.ownerId,
      },
      'headers': context.read<GlobalProvider>().headers,
    };

    _renterBloc.add(GetRenterDetailsEvent(params: params));
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AdaptiveBackButton(
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocListener(
        bloc: _renterBloc,
        listener: (context, state) {
          if (state is GenericRenterError) {
            context.pop();
            showErrorPopUp(state.errorMessage, context);
          }

          if (state is GetRenterDetailsLoaded) {
            final global = context.read<GlobalProvider>();
            final reservation = Reservation(
              id: null,
              car: _car,
              price: price,
              status: null,
              createdAt: null,
              updatedAt: null,
              renter: state.renter,
              destination: location.text,
              returnDate: endDate?.toIso8601String(),
              startDate: startDate?.toIso8601String(),
              customer: Customer(
                id: global.userDetails!.id,
                name: global.userDetails!.name,
              ),
            );
            context.pop();
            context.pushNamed(
              'makeReservationConfirmation',
              queryParameters: {
                'car': jsonEncode(_car?.toMap()),
                'renter': jsonEncode(state.renter.toMap()),
                'reservation': jsonEncode(reservation.toMap()),
              },
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(Sizes().height(context, 0.02)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Make Reservation",
                  style: theme.textTheme.titleSmall!.copyWith(
                    color: rentWheelsInformationDark900,
                  ),
                ),
                Space().height(context, 0.01),
                RichText(
                  text: TextSpan(
                    text:
                        "You can rent this ${_car?.make ?? ''} ${_car?.model ?? ''} for a maximum of ",
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: rentWheelsBrandDark900,
                    ),
                    children: [
                      TextSpan(
                        text:
                            ' ${_car?.maxDuration ?? ''} ${_car?.durationUnit ?? ''}',
                        style: theme.textTheme.headlineSmall!.copyWith(
                          color: rentWheelsBrandDark900,
                        ),
                      ),
                    ],
                  ),
                ),
                Space().height(context, 0.03),
                GenericTextField(
                    hint: 'Destination',
                    controller: location,
                    maxLines: 1,
                    onChanged: (value) => setState(() {
                          isLocationValid = value.length > 1;
                        })
                    // onTap: () async {
                    // final response = await Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => CustomSearchScaffold(),
                    //   ),
                    // );

                    // if (response != null) {
                    //   setState(() {
                    //     location.text = response;
                    //     isLocationValid = true;
                    //   });
                    // }
                    // }
                    ),
                Space().height(context, 0.03),
                TappableTextfield(
                  hint: 'Date',
                  controller: date,
                  onTap: showDateRangeSelector,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        color: rentWheelsNeutralLight0,
        height: Sizes().height(context, 0.2),
        padding: EdgeInsets.all(Sizes().height(context, 0.02)),
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
                  Text(
                    'Price',
                    style: theme.textTheme.headlineLarge!.copyWith(
                      color: rentWheelsInformationDark900,
                    ),
                  ),
                  Text(
                    "GH¢ $price",
                    style: theme.textTheme.headlineLarge!.copyWith(
                      color: rentWheelsInformationDark900,
                    ),
                  )
                ],
              ),
              Space().height(context, 0.04),
              GenericButton(
                isActive: isActive(),
                buttonName: 'Continue',
                width: Sizes().width(context, 0.85),
                onPressed: submitReservationDetails,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
