import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent_wheels/core/widgets/error/error_message_widget.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/widgets/loadingIndicator/shimmer_loading_placeholder.dart';
import 'package:rent_wheels/injection.dart';
import 'package:rent_wheels/src/global/presentation/provider/global_provider.dart';
import 'package:rent_wheels/src/reservations/presentation/bloc/reservations_bloc.dart';
import 'package:rent_wheels/src/reservations/presentation/widgets/reservations_data.dart';

class Reservations extends StatefulWidget {
  const Reservations({super.key});

  @override
  State<Reservations> createState() => _ReservationsState();
}

class _ReservationsState extends State<Reservations> {
  int _currentIndex = 0;
  final _reservationsBloc = sl<ReservationsBloc>();
  late GlobalProvider _globalProvider;

  getAllReservations() {
    final params = {
      'queryParameters': {
        'userId': context.read<GlobalProvider>().userDetails!.id,
      },
      'headers': context.read<GlobalProvider>().headers,
    };

    _reservationsBloc.add(GetAllReservationsEvent(params: params));
  }

  @override
  void initState() {
    getAllReservations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _globalProvider = context.watch<GlobalProvider>();
    return Scaffold(
      body: SafeArea(
        child: Shimmer(
          linearGradient: _globalProvider.shimmerGradient,
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: Sizes().width(context, 0.04)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Space().height(context, 0.04),
                Text(
                  "Reservations",
                  style: theme.textTheme.titleSmall!.copyWith(
                    color: rentWheelsInformationDark900,
                  ),
                ),
                Space().height(context, 0.02),
                Expanded(
                  child: BlocBuilder(
                    bloc: _reservationsBloc,
                    builder: (context, state) {
                      if (state is GenericReservationsError) {
                        return ErrorMessage(
                          label: 'An error occured',
                          errorMessage: state.errorMessage,
                        );
                      }

                      if (state is GetAllReservationsLoaded) {
                        final reservations = state.reservations;

                        reservations.sort(
                          (a, b) => b.createdAt!.compareTo(a.createdAt!),
                        );

                        return ReservationsData(
                          isLoading: false,
                          reservations: reservations,
                          currentIndex: _currentIndex,
                          filterButtonOnTap: (p0) => setState(() {
                            _currentIndex = p0;
                          }),
                        );
                      }
                      return const ReservationsData(
                        isLoading: true,
                        reservations: [],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
