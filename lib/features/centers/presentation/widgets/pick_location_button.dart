

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hello_pratice/core/app_colors.dart';
import 'package:hello_pratice/features/centers/application/bloc/center_bloc.dart';
import 'package:hello_pratice/features/centers/presentation/widgets/map_location_picker_dialog.dart';

class PickLocationButton extends StatelessWidget {
  final MapController mapController;
 
  const PickLocationButton({
    super.key,
    required this.mapController,
   
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () async {
        final latAndLon = await MapLocationPickerDialog.pickLocation(
          context: context,
          mapController: mapController,
       
        );
        // ignore: use_build_context_synchronously
        context.read<CenterBloc>().add(
          GetAddressFromCoordinatesRequested(
            lat: latAndLon!.latitude,
            lon: latAndLon.longitude,
          ),
        );
      },
      borderRadius: BorderRadius.all(Radius.circular(8)),
      child: Container(
        width: screenWidth * 0.897,
        height: screenHeight * 0.059,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: AppColors.secondary, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/icons/pick_location.svg'),
            SizedBox(width: 10),
            Text(
              'Pick from Map',
              style: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(color: AppColors.secondary),
            ),
          ],
        ),
      ),
    );
  }
}
