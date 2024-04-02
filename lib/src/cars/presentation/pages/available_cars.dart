import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rent_wheels/core/widgets/loadingIndicator/loading_indicator.dart';
import 'package:rent_wheels/core/widgets/popups/error_popup.dart';

import 'package:rent_wheels/injection.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/error/error_message_widget.dart';
import 'package:rent_wheels/core/widgets/loadingIndicator/shimmer_loading_placeholder.dart';
import 'package:rent_wheels/src/cars/domain/entity/cars.dart';

import 'package:rent_wheels/src/cars/presentation/bloc/cars_bloc.dart';
import 'package:rent_wheels/src/global/presentation/provider/global_provider.dart';
import 'package:rent_wheels/src/cars/presentation/widgets/available_cars_widget.dart';
import 'package:rent_wheels/src/renter/presentation/bloc/renter_bloc.dart';

class AvailableCars extends StatefulWidget {
  const AvailableCars({super.key});

  @override
  State<AvailableCars> createState() => _AvailableCarsState();
}

class _AvailableCarsState extends State<AvailableCars> {
  Car? _car;
  final _carsBloc = sl<CarsBloc>();
  final _renterBloc = sl<RenterBloc>();

  getAllCars() {
    final params = {
      'headers': context.read<GlobalProvider>().headers,
    };

    _carsBloc.add(GetAllAvailableCarsEvent(params: params));
  }

  getRenterDetails() {
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
    getAllCars();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Shimmer(
        linearGradient: context.read<GlobalProvider>().shimmerGradient,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Sizes().width(context, 0.04),
          ),
          child: BlocListener(
            bloc: _renterBloc,
            listener: (context, state) {
              if (state is GenericRenterError) {
                context.pop();
                showErrorPopUp(state.errorMessage, context);
              }

              if (state is GetRenterDetailsLoaded) {
                context.pop();
                context.pushNamed(
                  'carDetails',
                  pathParameters: {
                    'carId': _car!.id!,
                  },
                  queryParameters: {
                    'car': jsonEncode(_car!.toMap()),
                    'renter': jsonEncode(state.renter.toMap()),
                  },
                );
              }
            },
            child: BlocBuilder(
              bloc: _carsBloc,
              builder: (context, state) {
                if (state is GetAllAvailableCarsLoaded) {
                  return AvailableCarsHome(
                    cars: state.cars,
                    isLoading: false,
                    type: AvailableCarsType.allAvailableCars,
                    onTap: (p0) {
                      setState(() {
                        _car = state.cars[p0];
                      });
                      getRenterDetails();
                    },
                  );
                }

                if (state is GenericCarsError) {
                  return ErrorMessage(
                    label: 'An error occured',
                    errorMessage: state.errorMessage,
                  );
                }

                return const AvailableCarsHome(
                  cars: [],
                  type: AvailableCarsType.allAvailableCars,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
