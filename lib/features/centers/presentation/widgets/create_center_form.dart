import 'package:flutter/material.dart' hide Center;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hello_pratice/core/app_colors.dart';
import 'package:hello_pratice/core/app_snackbar.dart';
import 'package:hello_pratice/core/widgets/custom_button.dart';
import 'package:hello_pratice/features/centers/application/bloc/center_bloc.dart';
import 'package:hello_pratice/features/centers/presentation/widgets/map_picker_popup.dart';
import 'package:latlong2/latlong.dart';
import 'package:hello_pratice/features/centers/domain/entities/center.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateCenterForm extends StatefulWidget {
  const CreateCenterForm({super.key});

  @override
  State<CreateCenterForm> createState() => _CreateCenterFormState();
}

class _CreateCenterFormState extends State<CreateCenterForm> {
  // ignore: prefer_typing_uninitialized_variables
  MapController mapController = MapController();

  final TextEditingController centerNameController = TextEditingController();

  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  String location = '';

  @override
  void dispose() {
    super.dispose();
    mapController.dispose();
    centerNameController.dispose();
    phoneNumberController.dispose();
    locationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocConsumer<CenterBloc, CenterState>(
      listener: (context, state) {
        if (state is AddCenterSuccess) {
          AppSnackbar.show(context, message: state.message);

          context.read<CenterBloc>().add(GetAllCentersEvent());
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        final bool isLoading = state is AddCenterLoading;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Center Name',
              style: Theme.of(
                context,
              ).textTheme.headlineLarge?.copyWith(fontSize: 16),
            ),
            SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(hintText: 'Enter center name'),
              controller: centerNameController,
            ),
            SizedBox(height: 5),
            Text(
              'Minimum 3 characters required',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Color.fromRGBO(170, 183, 184, 1),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Location',
              style: Theme.of(
                context,
              ).textTheme.headlineLarge?.copyWith(fontSize: 16),
            ),
            SizedBox(height: 10),

            TextField(
              controller: locationController,
              onChanged: (value) {
                context.read<CenterBloc>().add(
                  LocationSearchQueryChanged(value),
                );
              },
              decoration: InputDecoration(
                hintText: 'Select location',
                prefixIcon: Icon(
                  Icons.location_on,
                  color: AppColors.textSecondary,
                ),
              ),
            ),

            BlocBuilder<CenterBloc, CenterState>(
              builder: (context, state) {
                if (state is LocationSearchLoaded) {
                  final suggestions = state.suggestions;
                  if (suggestions.isEmpty) {
                    return SizedBox(
                      child: Text(
                        'No suggestions found',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    );
                  }
                  return SizedBox(
                    height: 200,
                    child: ListView.builder(
                      itemCount: suggestions.length,
                      itemBuilder: (context, index) {
                        final suggestion = suggestions[index];
                        return ListTile(
                          title: Text(suggestion),
                          onTap: () {
                            locationController.text = suggestion;
                          },
                        );
                      },
                    ),
                  );
                } else if (state is LocationSearchError) {
                  AppSnackbar.show(context, message: state.message);
                }
                return SizedBox();
              },
            ),

            SizedBox(height: 15),
            Container(
              width: screenWidth * 0.897,

              height: screenHeight * 0.059,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Colors.transparent,
                border: Border.all(color: AppColors.quaternary, width: 1),
              ),
              child: InkWell(
                onTap: () async {
                  Future<String> getAddressFromLatLng(
                    double lat,
                    double lng,
                  ) async {
                    final url = Uri.parse(
                      "https://nominatim.openstreetmap.org/reverse?lat=$lat&lon=$lng&format=json",
                    );

                    final response = await http.get(
                      url,
                      headers: {"User-Agent": "flutter-app"},
                    );

                    if (response.statusCode == 200) {
                      final data = jsonDecode(response.body);
                      return data["display_name"] ?? "$lat, $lng";
                    } else {
                      return "$lat, $lng";
                    }
                  }

                  final LatLng? picked = await MapPickerPopup.showMap(
                    context,
                    mapController,
                  );

                  if (picked != null) {
                    final address = await getAddressFromLatLng(
                      picked.latitude,
                      picked.longitude,
                    );
                             
                    location = address;
                    
                    locationController.text = location;
                  }
                },

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/icons/pick_location.svg'),
                    SizedBox(width: 10),
                    Text(
                      'Pick from Map',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.quaternary,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 60),
            Text(
              'Phone Number',
              style: Theme.of(
                context,
              ).textTheme.headlineLarge?.copyWith(fontSize: 16),
            ),

            SizedBox(height: 10),
            TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(
                hintText: '+91-XXXXX-XXXXX',
                prefixIcon: Icon(Icons.call, color: AppColors.textSecondary),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Enter a valid phone number',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Color.fromRGBO(170, 183, 184, 1),
              ),
            ),

            SizedBox(height: 30),
            Divider(color: AppColors.borderPrimary, thickness: 1),
            SizedBox(height: 30),
            isLoading
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: CircularProgressIndicator(),
                  )
                : CustomButton(
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.0700,
                    backgroundColor: Color.fromRGBO(170, 183, 184, 1),
                    label: 'Create Center',
                    onTap: () {

                      print('Tapped on Tap');
                      context.read<CenterBloc>().add(
                        AddCenterRequested(
                          Center(
                            centerId: '',
                            adminName: '',
                            adminPhone: '',
                            adminEmail: '',
                            adminPassword: '',
                            name: centerNameController.text.trim(),
                            location: locationController.text.isEmpty
                                ? location.toString()
                                : locationController.text.trim(),
                            phone: phoneNumberController.text.trim(),
                          ),
                        ),
                      );
                      centerNameController.clear();
                      locationController.clear();
                      phoneNumberController.clear();
                      location = '';
                    },
                  ),
          ],
        );
      },
    );
  }
}
