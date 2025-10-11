import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hello_pratice/core/app_colors.dart';
import 'package:hello_pratice/features/centers/application/bloc/center_bloc.dart';
import 'package:hello_pratice/features/centers/presentation/widgets/map_marker_layer.dart';
import 'package:hello_pratice/features/centers/presentation/widgets/map_search_bar.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';

class MapLocationPickerDialog {
  static LatLng? markerPosition;
  static Future<LatLng?> pickLocation({
    required BuildContext context,
    required MapController mapController,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return showDialog<LatLng>(
      context: context,
      builder: (context) => BlocBuilder<CenterBloc, CenterState>(
        buildWhen: (previous, current) =>
            current is MarkerMoved || current is LocationLoaded,
        builder: (context, state) {
          //NON SEARCH MOVE

          markerPosition ??= LatLng(11.2588, 75.7804);
          if (state is MarkerMoved) {
            markerPosition = state.markerPosition;
          }

          //SEARCH MOVE

          if (state is LocationLoaded) {
            mapController.move(state.location, 13.5);
          }

          // ignore: deprecated_member_use
          return WillPopScope(
            onWillPop: () async {
              Navigator.pop(context, markerPosition);
              mapController.move(markerPosition!, 13.5);

              return false;
            },
            child: AlertDialog(
              backgroundColor: AppColors.tertiary,
              content: SizedBox(
                width: screenWidth * 0.9,
                height: screenHeight * 0.6,
                child: Column(
                  children: [
                    MapSearchBar(),
                    SizedBox(height: 30),
                    Expanded(
                      child: FlutterMap(
                        mapController: mapController,
                        options: MapOptions(
                          initialCenter: LatLng(11.2588, 75.7804),
                          initialZoom: 13.5,
                          onTap: (tapPosition, point) {
                            context.read<CenterBloc>().add(
                              MarkerMovedEvent(point),
                            );
                          },
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                "https://{s}.tile.openstreetmap.fr/osmfr/{z}/{x}/{y}.png",
                          ),

                          MapMarkerLayer(markerPosition!),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
