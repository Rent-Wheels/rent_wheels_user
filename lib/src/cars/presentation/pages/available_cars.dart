import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rent_wheels/injection.dart';

import 'package:rent_wheels/core/enums/enums.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/error/error_message_widget.dart';
import 'package:rent_wheels/core/widgets/loadingIndicator/shimmer_loading_placeholder.dart';

import 'package:rent_wheels/src/cars/presentation/bloc/cars_bloc.dart';
import 'package:rent_wheels/src/global/presentation/provider/global_provider.dart';
import 'package:rent_wheels/src/cars/presentation/widgets/available_cars_widget.dart';

class AvailableCars extends StatefulWidget {
  const AvailableCars({super.key});

  @override
  State<AvailableCars> createState() => _AvailableCarsState();
}

class _AvailableCarsState extends State<AvailableCars> {
  final _carsBloc = sl<CarsBloc>();

  getAllCars() {
    final params = {
      'headers': context.read<GlobalProvider>().headers,
    };

    _carsBloc.add(GetAllAvailableCarsEvent(params: params));
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
          child: BlocBuilder(
            bloc: _carsBloc,
            builder: (context, state) {
              if (state is GetAllAvailableCarsLoaded) {
                return AvailableCarsHome(
                  cars: state.cars,
                  isLoading: false,
                  type: AvailableCarsType.allAvailableCars,
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
    );
  }
}
