import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:rent_wheels/core/search/presentation/widgets/custom_search_modal.dart';

buildCustomSearchBottomSheet({
  required BuildContext context,
  required void Function(Prediction)? placeOnTap,
}) =>
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => CustomSearchModal(
        placeOnTap: placeOnTap,
      ),
    );
