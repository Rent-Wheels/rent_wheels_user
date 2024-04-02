import 'package:flutter/cupertino.dart';
import 'package:rent_wheels/core/widgets/loadingIndicator/shimmer_loading_placeholder.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/src/reservations/presentation/widgets/filter_buttons_widget.dart';
import 'package:rent_wheels/src/reservations/presentation/widgets/reservation_information_sections_widget.dart';

class ReservationsLoading extends StatelessWidget {
  final bool isLoading;

  const ReservationsLoading({
    super.key,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      isLoading: isLoading,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Sizes().height(context, 0.05),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                return FilterButtons(
                  width: Sizes().width(context, 0.2),
                  label: '',
                  onTap: null,
                );
              },
            ),
          ),
          Space().height(context, 0.02),
          Expanded(
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: Sizes().height(context, 0.04),
                  ),
                  child: const ReservationSections(
                    isLoading: true,
                    onPressed: null,
                    reservation: null,
                    car: null,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
