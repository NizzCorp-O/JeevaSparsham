import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hello_pratice/core/app_colors.dart';
import 'package:hello_pratice/features/centers/application/bloc/center_bloc.dart';
import 'package:latlong2/latlong.dart';

class MapPickerPopup {
  static Future<LatLng?> showMap(
    BuildContext context,
    MapController mapController,
  ) {
    LatLng pickedLocation = LatLng(11.0730, 76.0740);
    final TextEditingController searchController = TextEditingController();

    return showDialog<LatLng>(
      context: context,
      barrierDismissible: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return WillPopScope(
            onWillPop: () async {
              Navigator.pop(context, pickedLocation);
              return false;
            },
            child: AlertDialog(
              backgroundColor: AppColors.backgroundPrimary,
              content: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: const InputDecoration(
                            hintText: "Search location..",
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          context.read<CenterBloc>().add(
                            SearchLocationEvent(searchController.text),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: BlocBuilder<CenterBloc, CenterState>(
                      builder: (context, state) {
                        if (state is MapUpdated) {
                          pickedLocation = state.location!;
                          mapController.move(state.location!, 15.0);
                        }

                        return FlutterMap(
                          mapController: mapController,
                          options: MapOptions(
                            initialCenter: pickedLocation,
                            initialZoom: 13.0,
                            onTap: (tapPosition, point) {
                              setState(() {
                                pickedLocation = point;
                              });
                            },
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  "https://{s}.tile.openstreetmap.fr/osmfr/{z}/{x}/{y}.png",
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  width: 40,
                                  height: 40,
                                  child: const Icon(
                                    Icons.location_on,
                                    size: 40,
                                    color: Colors.red,
                                  ),
                                  point: pickedLocation,
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
